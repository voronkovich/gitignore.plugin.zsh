# gitignore.plugin.zsh [![Build Status](https://app.travis-ci.com/voronkovich/gitignore.plugin.zsh.svg?branch=master)](https://app.travis-ci.com/github/voronkovich/gitignore.plugin.zsh)

ZSH plugin for creating `.gitignore` files.

## Installation

### [Antigen](https://github.com/zsh-users/antigen)

```sh
antigen bundle voronkovich/gitingore.plugin.zsh
```
### [Zplug](https://github.com/zplug/zplug)

```sh
zplug "voronkovich/gitingore.plugin.zsh"
```

### [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

```sh
git clone --recurse-submodules https://github.com/voronkovich/gitingore.plugin.zsh ~/.oh-my-zsh/custom/plugins/gitingore
```

Edit `.zshrc` to enable the plugin:

```sh
plugins=(... gitingore)
```

### Manual

Clone this repo:

```sh
git clone --recurse-submodules https://github.com/voronkovich/gitingore.plugin.zsh path/to/repo
```

And add this into your `.zshrc`:

```sh
source path/to/repo/gitingore.plugin.zsh
```

## Usage

```sh
# Write templates to the standard output
gi TEMPLATE 

# Write templates to the local .gitignore file
gii TEMPLATE 

# Open .gitignore file in editor ($EDITOR)
gie
```

Example:

```sh
gi vim eclipse symfony
```

## Global gitignore

The plugin also supports [global gitignore](https://git-scm.com/docs/gitignore#_synopsis) files. To use global gitignore file instead of local one add `--global` flag to any command:

```sh
# Output content of the global gitignore file
gi -g

# Write templates to the global gitignore file
gii -g TEMPLATE 

# Open global gitignore file in editor ($EDITOR)
gie -g
```

## Custom templates

If you want to override an existing template or add your own custom one, you can use an environment variable `ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS` (it behaves like the `$PATH` variable):

```sh
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="${HOME}/.gitignore_teplates:${ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}:/etc/global_gitignore"
```

## Updating templates

Every day the [Travis CI](https://docs.travis-ci.com/user/cron-jobs/) runs a job (see [tools/update-templates](tools/update-templates)) that updates a submodule with templates and commits the changes. So, templates are always up to date. You should just use `antigen update`.

## Demo

![gif](http://i.imgur.com/NiaFzeh.gif)

## License

Copyright (c) Voronkovich Oleg. Distributed under the [MIT](LICENSE).
