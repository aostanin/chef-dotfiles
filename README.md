# chef-dotfiles

## Description

This cookbook lets you quickly and easily add a `.dotfiles` git repository to a user. The files inside are automatically linked into the user's home directory.

## Usage

This cookbook depends on the [users cookbook](http://community.opscode.com/cookbooks/users). Just add a `dotfilesrepo` to the user's data bag entry.

### Example

```json
{
  "id"          : "aostanin",
  ...
  "dotfilesrepo": "https://bitbucket.org/aostanin/dotfiles.git"
}
```

## License

Licensed under the Apache License, Version 2.0.

You may find a copy of the license at

```
http://www.apache.org/licenses/LICENSE-2.0
```

## References

- [Chef Users Cookbook](http://community.opscode.com/cookbooks/users)
