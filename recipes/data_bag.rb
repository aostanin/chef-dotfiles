bag = node['user']['data_bag_name']

user_array = node
node['user']['user_array_node_attr'].split("/").each do |hash_key|
  user_array = user_array.send(:[], hash_key)
end

Array(user_array).each do |i|
  u = data_bag_item(bag, i.gsub(/[.]/, '-'))
  username = u['username'] || u['id']

  unless u['dotfilesrepo'].nil?
    bash "#{username}_dotfiles_link" do
      action :nothing
      cwd "/home/#{username}/.dotfiles"
      user username
      group u['gid']
      code <<-EOH
        for FILE in `git ls-files`; do
            if test ! -d `dirname "${HOME}/${FILE}"`; then
                mkdir -p `dirname "${HOME}/${FILE}"`;
            fi;

            if test -e "${HOME}/${FILE}"; then
                rm "${HOME}/${FILE}";
            fi;

            ln -sf "${HOME}/.dotfiles/${FILE}" "${HOME}/${FILE}";
        done
        EOH
      environment 'HOME' => "/home/#{username}"
    end

    git "/home/#{username}/.dotfiles" do
      repository u['dotfilesrepo']
      user username
      group u['gid']
      action :sync
      enable_submodules true
      ignore_failure true
      only_if { File.directory?("/home/#{username}") }
      notifies :run, "bash[#{username}_dotfiles_link]"
    end

    directory "/home/#{username}/.dotfiles" do
      mode 0700
      recursive true
    end
  end
end
