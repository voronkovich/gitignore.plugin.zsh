export ZSH_PLUGIN_GITIGNORE_PATH=$(dirname $0)
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="$ZSH_PLUGIN_GITIGNORE_PATH/templates"

function gie () {
    $EDITOR .gitignore
}

function gi() {
    if [[ $? -eq 0 ]]; then
        cat .gitignore
    else
        for t in $*; do
            get_gitignore_template $t
        done
    fi
}

function gii() {
    # if NOCLOBBER option is setted
    gi $* >>! .gitignore
}

function get_gitignore_template() {
    for tpath in ${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}; do;
        local file=$(find $tpath  -iname "$1.gitignore")
        if  [[ ! -z $file ]]; then
            comment=$(basename $file | sed -e 's/.gitignore$//')
            echo
            echo "### $comment"
            cat $file
            break;
        fi
    done;
}

_gitignore_get_template_list() {
    (for tpath in ${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}; do; find $tpath -type f -name "*.gitignore"; done) \
        | xargs -n 1 basename \
        | sed -e 's/.gitignore$//' -e 's/\(.*\)/\L\1/' \
        | sort -u
}

_gitignore () {
  compset -P '*,'
  compadd -S '' `_gitignore_get_template_list`
}

compdef _gitignore gi
compdef _gitignore gii
