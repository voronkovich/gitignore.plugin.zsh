export ZSH_PLUGIN_GITIGNORE_PATH=$(dirname $0)
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="$ZSH_PLUGIN_GITIGNORE_PATH/templates"

function gie () {
    $EDITOR .gitignore
}

function gi() {
    if [[ $# -eq 0 ]]; then
        cat .gitignore
        return 0
    fi

    for t in $*; do
        _gitignore_template "$t"

        [[ $? -gt 0 ]] && echo -e "\n\e[31mGitignore template \e[0m\"$t\"\e[31m not found.\e[0m" >&2
    done

    return 0
}

function gii() {
    if [[ $# -eq 0 ]]; then
        gi
    else
        # if NOCLOBBER option is set
        gi $* >>! .gitignore
    fi
}

function _gitignore_template() {
    for tpath in ${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}; do;
        local file=$(find "$tpath"  -iname "$1.gitignore")
        if  [[ ! -z $file ]]; then
            comment=$(basename $file | sed -e 's/.gitignore$//')
            echo
            echo "### $comment"
            cat "$file"
            return 0;
        fi
    done;

    return 1;
}

_gitignore_get_template_list() {
    (for tpath in ${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}; do; find "$tpath" -type f -name "*.gitignore"; done) \
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
