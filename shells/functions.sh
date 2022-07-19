# Go back one or more directories and shows the content of the final directory
function b() {
    if [[ $# -eq 0 ]] ; then
        \cd ..
    elif [[ $# -eq 1 ]] ; then
        if echo $1 | grep -Eqv "^[0-9]+$" ; then
            >&2 echo "Argument should be a number"
            return 1
        fi

        initial_pwd=$(pwd)
        for i in $(seq 1 $1) ; do
            \cd ..
            if [[ $? -ne 0 ]] ; then
                \cd $initial_pwd
                return 2
            fi
        done
    else
        >&2 echo "Too many arguments"
        return 1
    fi

    ls
}

# back x amounts of directories and cd into the provided path
# if only on argument is provided either
#  - go back x directories
#  - back 1 directory and cd into the provided path
function bcd() {
    if [[ $# -eq 0 ]] ; then
        \cd ..
    elif [[ $# -eq 1 ]] ; then
        if echo $1 | grep -Eq "^[0-9]+$" ; then
            b $1
        else
            b &> /dev/null
            \cd $1
            ls
        fi
    elif [[ $# -eq 2 ]] ; then
        if echo $1 | grep -Eqv "^[0-9]+$" ; then
            >&2 echo "When providing two arguments the first should be a number"
            return 1
        fi

        initial_pwd=$(pwd)

        b $1 &> /dev/null
        if [[ $? -ne 0 ]] ; then
            \cd $initial_pwd
            return 1
        fi

        \cd $2 &> /dev/null
        if [[ $? -ne 0 ]] ; then
            \cd $initial_pwd
            return 1
        fi

        ls
    else
        >&2 echo "Too many arguments"
        return 1
    fi
}

function mkcd() {
    mkdir $1 && cd $1
}

function xo() {
    for arg in "$@" ; do
        nohup xdg-open $arg &> /dev/null
    done
}


# fco - checkout git branch/tag
# Source: https://github.com/junegunn/fzf/wiki/examples#git
git-checkout() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function _get_modified() {
    git status --porcelain=v2 | grep -v "^?" | grep "^. .\w" | cut -c114-
}

function _get_untracked() {
    git status --porcelain=v2 | grep "^?" | cut -c3-
}

git-add() {
    if ! is_in_git_repo ; then
        1>&2 echo "not a git repository"
        return 1
    fi

    m=$(_get_modified)
    u=$(_get_untracked)
    echo "$m$u" | fzf --height=10 -m | xargs -r git add
}

git-addm() {
    if ! is_in_git_repo ; then
        1>&2 echo "not a git repository"
        return 1
    fi

    _get_modified | fzf --height=10 -m | xargs -r git add
}


git-addu() {
    if ! is_in_git_repo ; then
        1>&2 echo "not a git repository"
        return 1
    fi

    _get_untracked | fzf --height=10 -m | xargs -r git add
}

git-restore() {
    if ! is_in_git_repo ; then
        1>&2 echo "not a git repository"
        return 1
    fi

    _get_modified | fzf --height=10 -m | xargs -r git restore
}

git-restore-staged() {
    if ! is_in_git_repo ; then
        1>&2 echo "not a git repository"
        return 1
    fi

    git status --porcelain=v2 | grep -v "^?" | grep "^. \w" | cut -c114- | fzf --height=10 -m | xargs -r git restore --staged
}

git-rmu() {
    if ! is_in_git_repo ; then
        1>&2 echo "not a git repository"
        return 1
    fi

    _get_untracked | fzf --height=10 -m | xargs -r rm "$@"
}
