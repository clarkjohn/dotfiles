# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# dircolors
if [ -f "$HOME/.dircolors" ] ; then
	eval $(dircolors -b $HOME/.dircolors)
fi

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# history
# keep history up to date, across sessions, in realtime
# http://unix.stackexchange.com/a/48113
export HISTCONTROL=ignoredups:erasedups
HISTFILESIZE=10000 
HISTSIZE=1000
HISTTIMEFORMAT="%a %b %Y %T "
shopt -s histappend
alias h=history

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# core aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# mv, rm, cp
alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'

# scp and ssh, skip banners
alias ssh='ssh -q'
alias scp='scp -q'

# always use color, even when piping (to awk,grep,etc)
#export CLICOLOR_FORCE=1

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# disk space
alias a-diskspace-disk-report="df -P -kHl"
alias a-diskspace-directories-over-1G="du -h . | grep '^\s*[0-9\.]\+G'"
alias a-diskspace-directories-over-1G-fast="du -h -d 3 . | grep '^\s*[0-9\.]\+G'"

# ls
alias l='ls -CF ${colorflag} --group-directories-first'
alias ls='ls -lAFhG ${colorflag} --group-directories-first'
alias ll='ls -ltrG ${colorflag} --group-directories-first'
alias ld='ls -l | grep "^d"' # only directories

# find shorthand
function f() {
	echo find . -iname "*$1*", with ls output
	find . -iname "*$1*" 2>&1 -exec ls -lhAFG --color --time-style long-iso {} \; | grep -v 'Permission denied' | grep -v 'total 0'
}
alias f-text-1-in-all-files-with-line-numbers="grep -Rnw ${colorflag} . -e "$1" 2>&1"

alias j="jobs"

# file size
alias fs="stat -f $1"

# git Autocomplete for 'g' and 'config' as well
complete -o default -o nospace -F _git g
complete -o default -o nospace -F _git config

# add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# fast cd, github.com/rupa/z
source ~/bin/z.sh

# git for dotfiles, linux or windows
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
function config(){
	case $(uname) in
		*MING*) /c/Program\ Files/Git/bin/git.exe --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@";;
		'Linux') /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@";;
	esac
}

case $(uname) in
	*MING*) 
		#windows
		# exports
		export PATH="$JAVA_HOME/bin:$ANT_HOME\bin:$CATALINA_HOME\bin:$M2_HOME\bin:$PATH"
				
		# prompt
		source ~/.bash_prompt.windows;

		# jq json windows executable parser
		alias jq='$HOME/bin/jq-win64'
		
		# print clipboard contents
		alias a-showclip='cat /dev/clipboard'
		
		# open explorer at current dir
		alias a-open-windows-explorer-here='cmd //c explorer .'
	;;
	'Linux') 
		# linux
		# exports
		if [ -e /usr/share/terminfo/x/xterm+256color ]; then
			export TERM='xterm+256color'
		elif [ -e /usr/share/terminfo/x/xterm-256color ]; then
			export TERM='xterm-256color'
		else
			export TERM='xterm-color'
		fi
		
		# prompt
		source ~/.bash_prompt.linux;
		
		# jq json linux executable parser
		alias jq='$HOME/bin/jq-linux64'
	;;
esac

# load the shell dotfiles, and then some:
# * ~/.functions more aliases and functions
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
