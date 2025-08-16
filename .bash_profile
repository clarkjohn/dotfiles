#!/usr/bin/env bash

# Load shell dotfiles, prioritizing common configurations.
# - ~/.paths: Custom PATH configurations.
# - ~/.bash_prompt: Custom shell prompt settings.
# - ~/.exports: Environment variables.
# - ~/.aliases: Command aliases.
# - ~/.functions: Shell functions.
# - ~/.extra: Personal settings not committed to version control.
# - ~/.history: History-related settings.
for file in ~/.paths ~/.bash_prompt ~/.exports ~/.aliases ~/.functions ~/.extra ~/.history; do
    if [[ -r "$file" && -f "$file" ]]; then
        source "$file"
    fi
done
unset file

# Enable dircolors for colored directory listings.
# Prioritize `gdircolors` (GNU coreutils) if available, otherwise use `dircolors`.
if command -v gdircolors &>/dev/null; then
    eval "$(gdircolors -b ~/.dircolors)"
elif command -v dircolors &>/dev/null; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# Enable case-insensitive globbing for pathname expansion.
shopt -s nocaseglob

# Add tab completion for SSH hostnames based on ~/.ssh/config.
# Excludes wildcard entries for more precise completion.
if [[ -e "$HOME/.ssh/config" ]]; then
    complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh
fi

# Enable Git branch name completion.
# Ensure the git-completion.bash script is downloaded and sourced.
# To get the script, run:
# curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
if [[ -f ~/.git-completion.bash ]]; then
    . ~/.git-completion.bash
fi

# Enable tab completion for `g` (common alias for `git`) and `dotfiles`.
# This requires `__git_complete` to be available from git-completion.bash.
if type __git_complete &>/dev/null; then
    __git_complete g __git_main
    __git_complete dotfiles __git_main
fi
