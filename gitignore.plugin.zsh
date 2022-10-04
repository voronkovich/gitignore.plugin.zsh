# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
export ZSH_PLUGIN_GITIGNORE_PATH="${0:h}"
export ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS="${ZSH_PLUGIN_GITIGNORE_PATH}/templates"

gie() {
    local opt_help opt_global file

    zparseopts -D {h,-help}=opt_help {g,-global}=opt_global || return 1

    if [[ -n "${opt_help}" ]]; then
        echo -ne "
Open gitignore file in editor (${EDITOR:-vim})

Usage:

  ${0} [OPTION]...

Options:

  -g, --global  Open global gitignore file
  -h, --help    Show this help message
"
        return
    fi

    _gitignore_detect_file || return

    "${EDITOR:-vim}" "${file}"
}

gi() {
    local opt_help opt_global file

    zparseopts -D {h,-help}=opt_help {g,-global}=opt_global || return 1

    if [[ -n "${opt_help}" ]]; then
        echo -ne "
Write specified templates to stdin

Usage:

  ${0} [OPTION]... [TEMPLATE]...

Options:

  -g, --global  Use global gitignore file
  -h, --help    Show this help message
"
        return
    fi

    if [[ $# -eq 0 ]]; then
        _gitignore_detect_file || return
        command cat "${file}"
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
    local opt_help opt_global file

    zparseopts -D {h,-help}=opt_help {g,-global}=opt_global || return 1

    if [[ -n "${opt_help}" ]]; then
        echo -ne "
Write specified templates to gitignore file

Usage:

  ${0} [OPTION]... [TEMPLATE]...

Options:

  -g, --global  Use global gitignore file
  -h, --help    Show this help message
"
        return
    fi

    _gitignore_detect_file || return

    if [[ $# -eq 0 ]]; then
        command cat "${file}"
        return
    fi

    # if NOCLOBBER option is set
    gi "$@" >>! "${file}"
}

_gitignore_detect_file() {
    if [[ -n "${opt_global}" ]]; then
        file="$(_gitignore_global)"

        if [[ -z "${file}" ]]; then
            echo "\nGlobal gitignore file not configured." >&2
            echo "\nTry:\n\n  git config --global core.excludesfile ~/.gitignore" >&2
            return 1
        fi
    else
        file="$(_gitignore_local)"
    fi
}

_gitignore_local() {
    local root="$(git rev-parse --show-toplevel 2>/dev/null)"

    echo "${root:-${PWD}}/.gitignore"
}

_gitignore_global() {
    local file="$(git config --global core.excludesfile 2>/dev/null)"

    echo "${file/\~\//${HOME}/}"
}

_gitignore_template() {
    local tpath file

    for tpath in "${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}"; do
        file="$(command find "${tpath}" -iname "${1}.gitignore")"
        if  [[ ! -z "${file}" ]]; then
            echo
            echo "### $(_gitignore_template_name "${file}")"
            command cat "${file}"
            return
        fi
    done

    return 1
}

_gitignore_template_name() {
    local file

    if [[ $# -gt 0 ]]; then
        for file; do
            echo "${${file:t}%.gitignore}"
        done
        return
    fi

    while read file; do
        echo "${${file:t:l}%.gitignore}"
    done | command sort -u
}

_gitignore_template_list() {
    local tpath

    for tpath in "${(@s/:/)ZSH_PLUGIN_GITIGNORE_TEMPLATE_PATHS}"; do
        command find "${tpath}" -type f -name "*.gitignore"
    done | _gitignore_template_name
}

_gitignore() {
  compset -P '*,'
  compadd -S '' $(_gitignore_template_list)
}

compdef _gitignore gi
compdef _gitignore gii
