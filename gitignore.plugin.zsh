# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
export ZSH_PLUGIN_GITIGNORE_PATH="${0:h}"
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="${ZSH_PLUGIN_GITIGNORE_PATH}/templates"

gie() {
    local root="$(command git rev-parse --show-toplevel 2>/dev/null)"

    "${EDITOR:-vim}" "${root}${root:+/}.gitignore"
}

gi() {
    if [[ $# -eq 0 ]]; then
        command cat .gitignore
        return
    fi

    local template

    for template; do
        _gitignore_template "${template}" || {
            echo -e "\n\e[31mGitignore template \e[0m\"${template}\"\e[31m not found.\e[0m" >&2
        }
    done
}

gii() {
    if [[ $# -eq 0 ]]; then
        gi
    else
        # if NOCLOBBER option is set
        gi "$@" >>! .gitignore
    fi
}

_gitignore_template() {
    local tpath file comment

    for tpath in "${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}"; do
        file="$(command find "${tpath}"  -iname "${1}.gitignore")"
        if  [[ ! -z "${file}" ]]; then
            comment=$(command basename "${file}" | command sed -e 's/.gitignore$//')
            echo
            echo "### ${comment}"
            command cat "${file}"
            return
        fi
    done

    return 1
}

_gitignore_get_template_list() {
    local tpath

    for tpath in "${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}"; do
        command find "${tpath}" -type f -name "*.gitignore"
    done \
        | command xargs -n 1 basename \
        | command sed -e 's/.gitignore$//' \
        | command tr '[:upper:]' '[:lower:]' \
        | command sort -u
}

_gitignore() {
  compset -P '*,'
  compadd -S '' "$(_gitignore_get_template_list)"
}

compdef _gitignore gi
compdef _gitignore gii
