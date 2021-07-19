#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#-------------------------------------------------------------
# If not running interactively, don't do anything
#-------------------------------------------------------------

case $- in
    *i*) ;;
      *) return;;
esac

#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------

if [ -f /etc/bashrc ]; then
    # shellcheck disable=SC1091
    . /etc/bashrc        # --> Read /etc/bashrc, if present.
elif [ -f /etc/bash.bashrc ]; then
    # shellcheck disable=SC1091
    . /etc/bash.bashrc   # --> Read /etc/bash.bashrc, if present.
fi

#-------------------------------------------------------------
# Use Bash completion, if installed
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#-------------------------------------------------------------

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    # shellcheck disable=SC1091
    . /etc/bash_completion
  fi
fi
# Setting builtins

# Show alterntaives in TAB-completion
bind 'set show-all-if-ambiguous on'
# Enable zsh-like TAB completion
bind 'TAB:menu-complete'

#-------------------------------------------------------------
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#-------------------------------------------------------------

if [ -f ~/.bash_aliases ]; then
    # shellcheck disable=SC1090
    . ~/.bash_aliases
fi

#-------------------------------------------------------------
# Terminal
#-------------------------------------------------------------

export TERM="xterm-256color"

#--------------------------------------------------------------
#  Automatic setting of $DISPLAY (if not set already).
#  This works for me - your mileage may vary. . . .
#  The problem is that different types of terminals give
#+ different answers to 'who am i' (rxvt in particular can be
#+ troublesome) - however this code seems to work in a majority
#+ of cases.
#--------------------------------------------------------------

function get_xserver {
    case $TERM in
        xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
            # Ane-Pieter Wieringa suggests the following alternative:
            #  I_AM=$(who am i)
            #  SERVER=${I_AM#*(}
            #  SERVER=${SERVER%*)}
            XSERVER=${XSERVER%%:*}
            ;;
            aterm | rxvt)
            # Find some code that works here. ...
            ;;
    esac
}

if [ -z "${DISPLAY:=""}" ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
       ${XSERVER} == "unix" ]]; then
          DISPLAY=":0.0"          # Display on local host.
    else
       DISPLAY=${XSERVER}:0.0     # Display on remote host.
    fi
fi

export DISPLAY

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

# enable for debugging bash
# set -o xtrace
# set -o nounset

# Exit bash after Ctrl-D pressed 10 times
# set -o ignoreeof
# Report the status of terminated background jobs immediately
set -o notify
# Prevent overwriting existing files with the > operator
set -o noclobber
# Fail early when pipe'ing bash commands
set -o pipefail

#-------------------------------------------------------------
# Some options
#-------------------------------------------------------------

# cd into the directory by typing only its name
shopt -s autocd
# Correct the typos in the cd command automatically
# shopt -s cdspell
# Check that a command exists before trying to execute it, otherwise perform a normal path search
shopt -s checkhash
# Do not exit shell if there are funning jobs
shopt -s checkjobs
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# Expand environment variable on TAB press
shopt -s direxpand
# Enable Bash Extended Globbing expressions
shopt -s extglob
# Supercharge your globbing experience
shopt -s globstar
# Append to the history file, don't overwrite it
shopt -s histappend
# Re-edit a failed history substitution.
shopt -s histreedit
# Print a command from history before executing the command
shopt -s histverify

#-------------------------------------------------------------
# History file
#-------------------------------------------------------------

# File to store history of commands called
HISTFILE=$HOME/.bash_history
# Don't put duplicate lines in the history.
HISTCONTROL=ignoredups:ignorespace
# Unlimited bash history
HISTSIZE=""
# Unlimited bash history
HISTFILESIZE=""
# History file format
export HISTTIMEFORMAT='%F %T '

#-------------------------------------------------------------
# Languages
#-------------------------------------------------------------

# Use correctly work on remote hosts
export LANG=en_US.UTF-8

#-------------------------------------------------------------
# PS1
# You will most likely want to make use of either `__posh_git_ps1` or
# `__posh_git_echo`. Refer to the documentation of the functions for additional
# information.
#
#
# CONFIG OPTIONS
# ==============
#
# This script should work out of the box. Available options are set through
# your git configuration files. This allows you to control the prompt display on a
# per-repository basis.
#
### bash.branchBehindAndAheadDisplay
#
# This option controls whether and how to display the number of commits by which
# the current branch is behind or ahead of its remote.
#
# 1   `full`: _Default_. Display count alongside the appropriate up/down arrow. If
#     both behind and ahead, use two separate arrows.
# 2   `compact`: Display count alongside the appropriate up/down arrow. If both
#     behind and ahead, display the behind count, then a double arrow, then the
#     ahead count.
# 3   `minimal`: Display the up/down or double arrow as appropriate, with no
#     counts.
#
# ### bash.describeStyle
#
# This option controls if you would like to see more information about the
# identity of commits checked out as a detached `HEAD`. This is also controlled
# by the legacy environment variable `GIT_PS1_DESCRIBESTYLE`.
#
#
# 1  `contains`: relative to newer annotated tag `(v1.6.3.2~35)`
# 2  `branch`: relative to newer tag or branch `(master~4)`
# 3  `describe`: relative to older annotated tag `(v1.6.3.1-13-gdd42c2f)`
# 4  `default`: exactly matching tag
#
# ### bash.enableFileStatus
#
# 1  `true`: _Default_. The script will query for all file indicators every time.
# 2  `false`: No file indicators will be displayed. The script will not query
#     upstream for differences. Branch color-coding information is still
#     displayed.
#
# ### bash.enableGitStatus
#
# 1  `true`: _Default_. Color coding and indicators will be shown.
# 2  `false`: The script will not run.
#
# ### bash.enableStashStatus
#
# 1  `true`: _Default_. An indicator will display if the stash is not empty.
# 2  `false`: An indicator will not display the stash status.
#
# ### bash.showStatusWhenZero
#
# 1  `true`:   Indicators will be shown even if there are no updates to the index or
#     working tree.
# 2  `false`: _Default_. No file change indicators will be shown if there are no
#    changes to the index or working tree.
#
# ### bash.showUpstream
#
# By default, `__posh_git_ps1` will compare `HEAD` to your `SVN` upstream if it can
# find one, or `@{upstream}` otherwise. This is also controlled by the legacy
# environment variable `GIT_PS1_SHOWUPSTREAM`.
#
# 1  `legacy`: Does not use the `--count` option available in recent versions of
#    `git-rev-list`
# 2  `git`: _Default_. Always compares `HEAD` to `@{upstream}`
# 3  `svn`: Always compares `HEAD` to `SVN` upstream
#
# ### bash.enableStatusSymbol
#
# 1  `true`: _Default_. Status symbols (`≡` `↑` `↓` `↕`) will be shown.
# 2  `false`: No status symbol will be shown, saving some prompt length.
#
###############################################################################

function __posh_color {
    echo \\[$1\\]
}

# Returns the location of the .git/ directory.
function __posh_gitdir {
    # Note: this function is duplicated in git-completion.bash
    # When updating it, make sure you update the other one to match.
    if [ -z "${1-}" ]; then
        if [ -n "${__posh_git_dir-}" ]; then
            echo "$__posh_git_dir"
        elif [ -n "${GIT_DIR-}" ]; then
            test -d "${GIT_DIR-}" || return 1
            echo "$GIT_DIR"
        elif [ -d .git ]; then
            echo .git
        else
            git rev-parse --git-dir 2>/dev/null
        fi
    elif [ -d "$1/.git" ]; then
        echo "$1/.git"
    else
        echo "$1"
    fi
}

# Echoes the git status string.
__posh_git_echo () {
    if [ "$(git config --bool bash.enableGitStatus)" = 'false' ]; then
        return;
    fi

    local red='\033[0;31m'
    local green='\033[0;32m'
    local bright_red='\033[0;91m'
    local bright_green='\033[0;92m'
    local bright_yellow='\033[0;93m'
    local bright_cyan='\033[0;96m'

    local default_foreground_color
    default_foreground_color=$(__posh_color '\e[m') # Default no color
    local default_background_color=

    local before_text='['
    local before_foreground_color
    before_foreground_color=$(__posh_color "$bright_yellow") # Yellow
    local before_background_color=
    local delim_text=' |'
    local delim_foreground_color
    delim_foreground_color=$(__posh_color "$bright_yellow") # Yellow
    local delim_background_color=

    local after_text=']'
    local after_foreground_color
    after_foreground_color=$(__posh_color "$bright_yellow") # Yellow
    local after_background_color=

    local branch_foreground_color
    branch_foreground_color=$(__posh_color "$bright_cyan")  # Cyan
    local branch_background_color=
    local branch_ahead_foreground_color
    branch_ahead_foreground_color=$(__posh_color "$bright_green") # green
    local branch_ahead_background_color=
    local branch_behind_foreground_color
    branch_behind_foreground_color=$(__posh_color "$bright_red") # red
    local branch_behind_background_color=
    local branch_behind_and_ahead_foreground_color
    branch_behind_and_ahead_foreground_color=$(__posh_color "$bright_yellow") # Yellow
    local branch_behind_and_ahead_background_color=

    local index_foreground_color
    index_foreground_color=$(__posh_color "$green") # Dark green
    local index_background_color=

    local working_foreground_color
    working_foreground_color=$(__posh_color "$red") # Dark red
    local working_background_color=

    local stash_foreground_color
    stash_foreground_color=$(__posh_color "$bright_red") # red
    local stash_background_color=
    local before_stash='('
    local after_stash=')'

    local local_default_status_symbol=''
    local local_working_status_symbol=' !'
    local local_working_status_color
    local_working_status_color=$(__posh_color "$red")
    local local_staged_status_color=' ~'
    local local_staged_status_color
    local_staged_status_color=$(__posh_color "$bright_cyan")

    local rebase_foreground_color
    rebase_foreground_color=$(__posh_color '\e[0m') # reset
    local rebase_background_color=

    local branch_behind_and_ahead_display
    branch_behind_and_ahead_display=$(git config --get bash.branchBehindAndAheadDisplay)
    if [ -z "$branch_behind_and_ahead_display" ]; then
        branch_behind_and_ahead_display="full"
    fi

    local enable_file_status
    enable_file_status=$(git config --bool bash.enableFileStatus)
    case "$enable_file_status" in
        true)  enable_file_status=true ;;
        false) enable_file_status=false ;;
        *)     enable_file_status=true ;;
    esac
    local show_status_when_zero
    show_status_when_zero=$(git config --bool bash.showStatusWhenZero)
    case "$show_status_when_zero" in
        true)  show_status_when_zero=true ;;
        false) show_status_when_zero=false ;;
        *)     show_status_when_zero=false ;;
    esac
    local enable_stash_status
    enable_stash_status=$(git config --bool bash.enableStashStatus)
    case "$enable_stash_status" in
        true)  enable_stash_status=true ;;
        false) enable_stash_status=false ;;
        *)     enable_stash_status=true ;;
    esac
    local enable_status_symbol
    enable_status_symbol=$(git config --bool bash.enableStatusSymbol)
    case "$enable_status_symbol" in
        true)  enable_status_symbol=true ;;
        false) enable_status_symbol=false ;;
        *)     enable_status_symbol=true ;;
    esac

    local branch_identical_status_symbol=''
    local branch_ahead_status_symbol=''
    local branch_behind_status_symbol=''
    local branch_behind_and_ahead_status_symbol=''
    local branch_warning_status_symbol=''
    if $enable_status_symbol; then
      branch_identical_status_symbol=$' \xE2\x89\xA1' # Three horizontal lines
      branch_ahead_status_symbol=$' \xE2\x86\x91' # Up Arrow
      branch_behind_status_symbol=$' \xE2\x86\x93' # Down Arrow
      branch_behind_and_ahead_status_symbol=$'\xE2\x86\x95' # Up and Down Arrow
      branch_warning_status_symbol=' ?'
    fi

    # these globals are updated by __posh_git_ps1_upstream_divergence
    __POSH_BRANCH_AHEAD_BY=0
    __POSH_BRANCH_BEHIND_BY=0

    local git_repo
    git_repo=$(__posh_gitdir "$@")
    if [ -z "$git_repo" ]; then
        return # not a git directory
    fi
    local rebase=''
    local b=''
    local step=''
    local total=''
    if [ -d "$git_repo/rebase-merge" ]; then
        b=$(cat "$git_repo/rebase-merge/head-name" 2>/dev/null)
        step=$(cat "$git_repo/rebase-merge/msgnum" 2>/dev/null)
        total=$(cat "$git_repo/rebase-merge/end" 2>/dev/null)
        if [ -f "$git_repo/rebase-merge/interactive" ]; then
            rebase='|REBASE-i'
        else
            rebase='|REBASE-m'
        fi
    else
        if [ -d "$git_repo/rebase-apply" ]; then
            step=$(cat "$git_repo/rebase-apply/next")
            total=$(cat "$git_repo/rebase-apply/last")
            if [ -f "$git_repo/rebase-apply/rebasing" ]; then
                rebase='|REBASE'
            elif [ -f "$git_repo/rebase-apply/applying" ]; then
                rebase='|AM'
            else
                rebase='|AM/REBASE'
            fi
        elif [ -f "$git_repo/MERGE_HEAD" ]; then
            rebase='|MERGING'
        elif [ -f "$git_repo/CHERRY_PICK_HEAD" ]; then
            rebase='|CHERRY-PICKING'
        elif [ -f "$git_repo/REVERT_HEAD" ]; then
            rebase='|REVERTING'
        elif [ -f "$git_repo/BISECT_LOG" ]; then
            rebase='|BISECTING'
        fi

        b=$(git symbolic-ref HEAD 2>/dev/null) || {
            local output
            output=$(git config -z --get bash.describeStyle)
            if [ -n "$output" ]; then
                GIT_PS1_DESCRIBESTYLE=$output
            fi
            b=$(
            case "${GIT_PS1_DESCRIBESTYLE-}" in
            contains )
                git describe --contains HEAD ;;
            branch )
                git describe --contains --all HEAD ;;
            describe )
                git describe HEAD ;;
            default )
                git describe --tags --exact-match HEAD ;;
            * )
                git describe --tags --exact-match HEAD ;;
            esac 2>/dev/null) ||

            b=$(cut -c1-7 "$git_repo/HEAD" 2>/dev/null)... ||
            b='unknown'
            b="($b)"
        }
    fi

    if [ -n "$step" ] && [ -n "$total" ]; then
        rebase="$rebase $step/$total"
    fi

    local has_stash=false
    local stash_count=0
    local is_bare=''

    if [ 'true' = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
        if [ 'true' = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
            is_bare='BARE:'
        else
            b='GIT_DIR!'
        fi
    elif [ 'true' = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
        if $enable_stash_status; then
            git rev-parse --verify refs/stash >/dev/null 2>&1 && has_stash=true
            if $has_stash; then
                stash_count=$(git stash list | wc -l | tr -d '[:space:]')
            fi
        fi
        __posh_git_ps1_upstream_divergence
        local divergence_return_code=$?
    fi

    # show index status and working directory status
    if $enable_file_status; then
        local index_added=0
        local index_modified=0
        local index_deleted=0
        local index_unmerged=0
        local files_added=0
        local filed_modified=0
        local files_deleted=0
        local files_unmerged=0
        while IFS=$'\n' read -r tag rest
        do
            case "${tag:0:1}" in
                A )
                    (( index_added++ ))
                    ;;
                M )
                    (( index_modified++ ))
                    ;;
                T )
                    (( index_modified++ ))
                    ;;
                R )
                    (( index_modified++ ))
                    ;;
                C )
                    (( index_modified++ ))
                    ;;
                D )
                    (( index_deleted++ ))
                    ;;
                U )
                    (( index_unmerged++ ))
                    ;;
            esac
            case "${tag:1:1}" in
                \? )
                    (( files_added++ ))
                    ;;
                A )
                    (( files_added++ ))
                    ;;
                M )
                    (( filed_modified++ ))
                    ;;
                T )
                    (( filed_modified++ ))
                    ;;
                D )
                    (( files_deleted++ ))
                    ;;
                U )
                    (( files_unmerged++ ))
                    ;;
            esac
        done <<< "$(git status --porcelain 2>/dev/null)"
    fi

    local git_string=
    local branch_string="$is_bare${b##refs/heads/}"

    # before-branch text
    git_string="$before_background_color$before_foreground_color$before_text"

    # branch
    if (( __POSH_BRANCH_BEHIND_BY > 0 && __POSH_BRANCH_AHEAD_BY > 0 )); then
        git_string+="$branch_behind_and_ahead_background_color$branch_behind_and_ahead_foreground_color$branch_string"
        if [ "$branch_behind_and_ahead_display" = "full" ]; then
            git_string+="$branch_behind_status_symbol$__POSH_BRANCH_BEHIND_BY$branch_ahead_status_symbol$__POSH_BRANCH_AHEAD_BY"
        elif [ "$branch_behind_and_ahead_display" = "compact" ]; then
            git_string+=" $__POSH_BRANCH_BEHIND_BY$branch_behind_and_ahead_status_symbol$__POSH_BRANCH_AHEAD_BY"
        else
            git_string+=" $branch_behind_and_ahead_status_symbol"
        fi
    elif (( __POSH_BRANCH_BEHIND_BY > 0 )); then
        git_string+="$branch_behind_background_color$branch_behind_foreground_color$branch_string"
        if [ "$branch_behind_and_ahead_display" = "full" ] || [ "$branch_behind_and_ahead_display" = "compact" ]; then
            git_string+="$branch_behind_status_symbol$__POSH_BRANCH_BEHIND_BY"
        else
            git_string+="$branch_behind_status_symbol"
        fi
    elif (( __POSH_BRANCH_AHEAD_BY > 0 )); then
        git_string+="$branch_ahead_background_color$branch_ahead_foreground_color$branch_string"
        if [ "$branch_behind_and_ahead_display" = "full" ] || [ "$branch_behind_and_ahead_display" = "compact" ]; then
            git_string+="$branch_ahead_status_symbol$__POSH_BRANCH_AHEAD_BY"
        else
            git_string+="$branch_ahead_status_symbol"
        fi
    elif (( divergence_return_code )); then
        # ahead and behind are both 0, but there was some problem while executing the command.
        git_string+="$branch_background_color$branch_foreground_color$branch_string$branch_warning_status_symbol"
    else
        # ahead and behind are both 0, and the divergence was determined successfully
        git_string+="$branch_background_color$branch_foreground_color$branch_string$branch_identical_status_symbol"
    fi

    git_string+="${rebase:+$rebase_foreground_color$rebase_background_color$rebase}"

    # index status
    if $enable_file_status; then
        local index_count="$(( index_added + index_modified + index_deleted + index_unmerged ))"
        local working_count="$(( files_added + filed_modified + files_deleted + files_unmerged ))"

        if (( index_count != 0 )) || $show_status_when_zero; then
            git_string+="$index_background_color$index_foreground_color +$index_added ~$index_modified -$index_deleted"
        fi
        if (( index_unmerged != 0 )); then
            git_string+=" $index_background_color$index_foreground_color!$index_unmerged"
        fi
        if (( index_count != 0 && (working_count != 0 || show_status_when_zero) )); then
            git_string+="$delim_background_color$delim_foreground_color$delim_text"
        fi
        if (( working_count != 0 )) || $show_status_when_zero; then
            git_string+="$working_background_color$working_foreground_color +$files_added ~$filed_modified -$files_deleted"
        fi
        if (( files_unmerged != 0 )); then
            git_string+=" $working_background_color$working_foreground_color!$files_unmerged"
        fi

        local local_status_symbol=$local_default_status_symbol
        local local_status_color=$default_foreground_color

        if (( working_count != 0 )); then
            local_status_symbol=$local_working_status_symbol
            local_status_color=$local_working_status_color
        elif (( index_count != 0 )); then
            local_status_symbol=$local_staged_status_color
            local_status_color=$local_staged_status_color
        fi

        git_string+="$default_background_color$local_status_color$local_status_symbol$default_foreground_color"

        if $enable_stash_status && $has_stash; then
            git_string+="$default_background_color$default_foreground_color $stash_background_color$stash_foreground_color$before_stash$stash_count$after_stash"
        fi
    fi

    # after-branch text
    git_string+="$after_background_color$after_foreground_color$after_text$default_background_color$default_foreground_color"
    echo "$git_string"
}

# Updates the global variables `__POSH_BRANCH_AHEAD_BY` and `__POSH_BRANCH_BEHIND_BY`.
__posh_git_ps1_upstream_divergence ()
{
    local key value
    local svn_remote svn_url_pattern
    local upstream=git          # default
    local legacy=''

    svn_remote=()
    # get some config options from git-config
    local output
    output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showUpstream)$' 2>/dev/null | tr '\0\n' '\n ')"
    while read -r key value; do
        case "$key" in
        bash.showUpstream)
            GIT_PS1_SHOWUPSTREAM="$value"
            if [ -z "${GIT_PS1_SHOWUPSTREAM}" ]; then
                return
            fi
            ;;
        svn-remote.*.url)
            svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
            svn_url_pattern+="\\|$value"
            upstream=svn+git # default upstream is SVN if available, else git
            ;;
        esac
    done <<< "$output"

    # parse configuration values
    for option in ${GIT_PS1_SHOWUPSTREAM}; do
        case "$option" in
        git|svn) upstream="$option" ;;
        legacy)  legacy=1  ;;
        esac
    done

    # Find our upstream
    case "$upstream" in
    git)    upstream='@{upstream}' ;;
    svn*)
        # get the upstream from the "git-svn-id: ..." in a commit message
        # (git-svn uses essentially the same procedure internally)
        local svn_upstreams=()
        while IFS='' read -r line; do
            svn_upstreams+=("$line");
        done < <(git log --first-parent -1 --grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null)
        if (( 0 != ${#svn_upstream[@]} )); then
            svn_upstream=${svn_upstreams[ ${#svn_upstreams[@]} - 2 ]}
            svn_upstream=${svn_upstream%@*}
            local n_stop="${#svn_remote[@]}"
            local n
            for ((n=1; n <= n_stop; n++)); do
                svn_upstream=${svn_upstream#${svn_remote[$n]}}
            done

            if [ -z "$svn_upstream" ]; then
                # default branch name for checkouts with no layout:
                upstream=${GIT_SVN_ID:-git-svn}
            else
                upstream=${svn_upstream#/}
            fi
        elif [ 'svn+git' = "$upstream" ]; then
            upstream='@{upstream}'
        fi
        ;;
    esac

    local return_code=
    __POSH_BRANCH_AHEAD_BY=0
    __POSH_BRANCH_BEHIND_BY=0
    # Find how many commits we are ahead/behind our upstream
    if [ -z "$legacy" ]; then
        local output=
        output=$(git rev-list --count --left-right $upstream...HEAD 2>/dev/null)
        return_code=$?
        IFS=$' \t\n' read -r __POSH_BRANCH_BEHIND_BY __POSH_BRANCH_AHEAD_BY <<< "$output"
    else
        local output
        output=$(git rev-list --left-right $upstream...HEAD 2>/dev/null)
        return_code=$?
        # produce equivalent output to --count for older versions of git
        while IFS=$' \t\n' read -r commit; do
            case "$commit" in
            "<*") (( __POSH_BRANCH_BEHIND_BY++ )) ;;
            ">*") (( __POSH_BRANCH_AHEAD_BY++ ))  ;;
            esac
        done <<< "$output"
    fi
    : "${__POSH_BRANCH_AHEAD_BY:=0}"
    : "${__POSH_BRANCH_BEHIND_BY:=0}"
    return $return_code
}


function __now {
    date +%s%N
}

function __prompt_command_start {
    __prompt_command_start=${__prompt_command_start:-$(__now)}
}

function __prompt_command_stop {
    # shellcheck disable=SC2004
    local delta_us=$((($(__now) - $__prompt_command_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then
        timer_show=${h}h${m}m
    elif ((m > 0)); then
        timer_show=${m}m${s}s
    elif ((s >= 10)); then
        timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then
        timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then
        timer_show=${ms}ms
    elif ((ms > 0)); then
        timer_show=${ms}.$((us / 100))ms
    else
        timer_show=${us}us
    fi
    unset __prompt_command_start
}


function __prompt_command {
    # Must come first!
    local last_command=$?
    local bold_yellow
    bold_yellow=$(__posh_color '\033[01;33m')
    local bold_blue
    bold_blue=$(__posh_color '\033[01;34m')
    local bold_white
    bold_white=$(__posh_color '\033[01;37m')
    local bold_red
    bold_red=$(__posh_color '\033[01;31m')
    local bold_green
    bold_green=$(__posh_color '\033[01;32m')
    local faint_green
    faint_green=$(__posh_color '\033[02;32m')
    local reset
    reset=$(__posh_color '\033[00m')
    local fancy_x='\342\234\227'
    local checkmark='\342\234\223'
    local newline='\n'

    # Show virtual environment if any
    local ps1_env=""
    if [ -n "$VIRTUAL_ENV" ]; then
        ps1_env+="$bold_yellow("
        ps1_env+=$(basename "$VIRTUAL_ENV")
        ps1_env+=")$reset "
    fi

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    local ps1_loc
    ps1_loc=""
    if [[ $EUID == 0 ]]; then
        ps1_loc+="$bold_red\\u$bold_green@\\h "
    else
        ps1_loc+="$bold_green\\u@\\h "
    fi
    ps1_loc+="$reset"

    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    local git_string
    git_string=$(__posh_git_echo "$@")
    local ps1_git="$bold_blue\\w $git_string$reset "

    # Add a bright white exit status for the last command
    local ps1_status="$bold_white\$? "
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $last_command == 0 ]]; then
        ps1_status+="$faint_green$checkmark "
    else
        ps1_status+="$bold_red$fancy_x "
    fi

    # Add the ellapsed time and current date
    __prompt_command_stop
    local ps1_time
    ps1_time+="($timer_show) \t $reset"

    # Add symbol
    local ps1_symbol="$newline"
    if [[ $last_command == 0 ]]; then
        ps1_symbol+="$bold_green\\\$ "
    else
        ps1_symbol+="$bold_red\\\$ "
    fi
    ps1_symbol+="$reset"
    PS1="${ps1_env}${ps1_loc}${ps1_git}${ps1_status}${ps1_time}${ps1_symbol}"
}

trap '__prompt_command_start' DEBUG
PROMPT_COMMAND='__prompt_command'

#-------------------------------------------------------------
# Sound
#-------------------------------------------------------------

# Turn off annoying terminal sound
bind 'set bell-style none'

#-------------------------------------------------------------
# Tools
#-------------------------------------------------------------

#-------------------------------------------------------------
# less
#-------------------------------------------------------------

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

#-------------------------------------------------------------
# gcc
#-------------------------------------------------------------

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#-------------------------------------------------------------
# ls
#-------------------------------------------------------------

export LSCOLORS='Gxfxcxdxbxegedabagacad'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliase
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
