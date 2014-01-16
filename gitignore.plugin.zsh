export ZSH_PLUGIN_GITIGNORE_PATH=$(dirname $(readlink -f $0))

function gi() {
    template=$(find $ZSH_PLUGIN_GITIGNORE_PATH/templates -iname "$1.gitignore")
    if [[ ! -z $template ]]; then
        echo "# $(basename $template | sed -e 's/.gitignore$//')"
        cat $template
    fi
}

function gii() {
    template=$(find $ZSH_PLUGIN_GITIGNORE_PATH/templates -iname "$1.gitignore")
    if [[ ! -z $template ]]; then
        echo "# $(basename $template | sed -e 's/.gitignore$//')" >> .gitignore
        cat $template >> .gitignore
    fi
}

_gitignore_get_template_list() {
    find $ZSH_PLUGIN_GITIGNORE_PATH/templates -type f -name "*.gitignore" | xargs basename -a | sed -e 's/.gitignore$//' -e 's/\(.*\)/\L\1/'
}

_gitignore () {
  compset -P '*,'
  compadd -S '' `_gitignore_get_template_list`
}

compdef _gitignore gi
compdef _gitignore gii
