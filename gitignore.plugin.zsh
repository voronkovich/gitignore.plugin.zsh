export ZSH_PLUGIN_GITIGNORE_PATH=$(dirname $0)

function gie () {
    $EDITOR .gitignore
}

function gi() {
    for t in $*; do
        get_gitignore_template $t
    done
}

function gii() {
    gi $* >> .gitignore
}

function get_gitignore_template() {
    file=$(find $ZSH_PLUGIN_GITIGNORE_PATH/templates -iname "$1.gitignore")
    if  [[ ! -z $file ]]; then
        comment=$(basename $file | sed -e 's/.gitignore$//')
        echo
        echo "### $comment"
        cat $file
    fi
}

_gitignore_get_template_list() {
    find $ZSH_PLUGIN_GITIGNORE_PATH/templates -type f -name "*.gitignore" | xargs -n 1 basename | sed -e 's/.gitignore$//' -e 's/\(.*\)/\L\1/'
}

_gitignore () {
  compset -P '*,'
  compadd -S '' `_gitignore_get_template_list`
}

compdef _gitignore gi
compdef _gitignore gii
