#!/usr/bin/env bash

# load the shell dotfiles, and then some:
# * ~/.functions more aliases and functions
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{paths,bash_prompt,exports,aliases,functions,extra,history}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# enable dircolors
command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
if which gdircolors > /dev/null; then
    eval "$(gdircolors -b ~/.dircolors)"
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh s;

# Enable git branch name completion. 
# curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
if [ -f ~/.git-completion.bash ]; then
. ~/.git-completion.bash
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type __git_complete &> /dev/null; then
    __git_complete g __git_main
    __git_complete dotfiles __git_main
fi;
