# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
export ZSH_PLUGIN_GITIGNORE_PATH=${0:h}
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="$ZSH_PLUGIN_GITIGNORE_PATH/templates"

function gie () {
    local root_path="$(git rev-parse --show-toplevel 2>/dev/null)"
    "${EDITOR:-vim}" "$root_path"${root_path:+/}.gitignore
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
            comment=$(command basename $file | sed -e 's/.gitignore$//')
            echo
            echo "### $comment"
            cat "$file"
            return 0;
        fi
    done;

    return 1;
}

_gitignore_get_template_list() {
    (for tpath in ${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}; do; command find "$tpath" -type f -name "*.gitignore"; done) \
        | command xargs -n 1 basename \
        | command sed -e 's/.gitignore$//' \
        | command tr '[:upper:]' '[:lower:]' \
        | command sort -u
}

_gitignore () {
  compset -P '*,'
  compadd -S '' `_gitignore_get_template_list`
}

compdef _gitignore gi
compdef _gitignore gii
