# gitignore.plugin.zsh

[![Tests](https://github.com/voronkovich/gitignore.plugin.zsh/actions/workflows/tests.yml/badge.svg)](https://github.com/voronkovich/gitignore.plugin.zsh/actions/workflows/tests.yml)
[![Update Templates](https://github.com/voronkovich/gitignore.plugin.zsh/actions/workflows/update-templates.yml/badge.svg)](https://github.com/voronkovich/gitignore.plugin.zsh/actions/workflows/update-templates.yml)

ZSH plugin for creating `.gitignore` files.

## Demo

![gif](http://i.imgur.com/NiaFzeh.gif)

## Usage

```sh
# Write templates to the standard output
gi TEMPLATE

# Append templates to the local .gitignore file
gii TEMPLATE

# Open .gitignore file in editor ($EDITOR)
gie
```

Example:

```sh
gi vim eclipse symfony
```

## Installation

### [Antigen](https://github.com/zsh-users/antigen)

```sh
antigen bundle voronkovich/gitignore.plugin.zsh
```
### [Zplug](https://github.com/zplug/zplug)

```sh
zplug "voronkovich/gitignore.plugin.zsh"
```

### [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)

```sh
git clone --recurse-submodules https://github.com/voronkovich/gitignore.plugin.zsh ~/.oh-my-zsh/custom/plugins/gitignore
```

Edit `.zshrc` to enable the plugin:

```sh
plugins=(... gitignore)
```

### Manual

Clone this repo:

```sh
git clone --recurse-submodules https://github.com/voronkovich/gitignore.plugin.zsh path/to/repo
```

And add this into your `.zshrc`:

```sh
source path/to/repo/gitignore.plugin.zsh
```

## Advanced Usage

### Global gitignore

The plugin also supports [global gitignore](https://git-scm.com/docs/gitignore#_synopsis) files. To use the global gitignore file instead of the local one, add the `--global` flag to any command:

```sh
# Show current global gitignore file's content
gi -g

# Append templates to the global gitignore file
gii -g TEMPLATE

# Open global gitignore file in editor ($EDITOR)
gie -g
```

### Custom templates

If you want to override an existing template or add your own custom one, you can use an environment variable `ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS` (it behaves like the `$PATH` variable):

```sh
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="${HOME}/.gitignore_templates:${ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}:/etc/global_gitignore"
```

## Updating templates

Every day a [GitHub Actions](https://docs.github.com/en/actions/scheduling-your-workflows/scheduling-your-workflow) scheduled workflow runs a job that updates a submodule with templates and commits the changes. So, templates are always up to date. You should just use `antigen update`.

## License

Copyright (c) Voronkovich Oleg. Distributed under the [MIT](LICENSE).
