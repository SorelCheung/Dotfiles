# Alias
alias cl='curl -L -C - -O --retry 5'
alias vi='gvim'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias sf='screenfetch'
alias cf='colordiff'
alias md='firefox *.md'
alias axel='axel -a -n 9'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'


# Function
# One command to extract compressed files
alias x='extract'
extract() {
    local opt
    local OPTIND=1
    while getopts "hv" opt; do
        case "$opt" in
            h)
                cat <<End-Of-Usage
Usage: ${FUNCNAME[0]} [option] <archives>
    options:
        -h  show this message and exit
        -v  verbosely list files processed
End-Of-Usage
                return
                ;;
            v)
                local -r verbose='v'
                ;;
            ?)
                extract -h >&2
                return 1
                ;;
        esac
    done
    shift $((OPTIND-1))
    [ $# -eq 0 ] && extract -h && return 1
    while [ $# -gt 0 ]; do
	    if [ -f "$1" ]; then
		    case "$1" in
                *.tar.bz2|*.tbz|*.tbz2) tar "x${verbose}jf" "$1" ;;
                *.tar.gz|*.tgz) tar "x${verbose}zf" "$1" ;;
                *.tar.xz) xz --decompress "$1"; set -- "$@" "${1:0:-3}" ;;
                *.tar.Z) uncompress "$1"; set -- "$@" "${1:0:-2}" ;;
                *.bz2) bunzip2 "$1" ;;
                *.deb) dpkg-deb -x${verbose} "$1" "${1:0:-4}" ;;
                *.pax.gz) gunzip "$1"; set -- "$@" "${1:0:-3}" ;;
                *.gz) gunzip "$1" ;;
                *.pax) pax -r -f "$1" ;;
                *.pkg) pkgutil --expand "$1" "${1:0:-4}" ;;
                *.rar) unrar x "$1" ;;
                *.rpm) rpm2cpio "$1" | cpio -idm${verbose} ;;
                *.tar) tar "x${verbose}f" "$1" ;;
                *.txz) mv "$1" "${1:0:-4}.tar.xz"; set -- "$@" "${1:0:-4}.tar.xz" ;;
                *.xz) xz --decompress "$1" ;;
                *.zip|*.war|*.jar) unzip "$1" ;;
                *.Z) uncompress "$1" ;;
                *.7z) 7za x "$1" ;;
                *) echo "'$1' cannot be extracted via extract" >&2;;
		    esac
        else
		    echo "extract: '$1' is not a valid file" >&2
	    fi
        shift
    done
}

# A simple pomodoro
remindme() { 
    sleep $1 && zenity --info --text "$2" &
}
alias wk='remindme 25m "Sleep for 5 minutes!"'
alias sl='remindme 1m "Start to work!"'

# Create a directory and enter it
cde () {
    mkdir -p $1
    cd $1
}

# Kill processes by name
kp () {
  ps aux | grep $1 > /dev/null
  mypid=$(pidof $1)
  if [ "$mypid" != "" ]; then
    kill -9 $(pidof $1)
    if [[ "$?" == "0" ]]; then
      echo "PID $mypid ($1) has been killed."
    fi
  else
    echo "Nothing has been killed."
  fi
  return;
}


# Misc
# Using vi-mode in bash
set -o vi
# Make Vim the default editor
EDITOR=vim
export EDITOR

# Colorful manpages
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan 
