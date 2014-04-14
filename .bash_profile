# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load git branch completion script
source "$HOME/.bin/git-completion.bash"

# Load the custom prompt
source "$HOME/.bin/config.bash"
source "$HOME/.bin/prompt.bash"
source "$HOME/.bin/special-dates.bash"

export PATH=/usr/local/bin:$PATH

alias home="ssh home -p 2010"
alias wip="git commit -am 'WIP'"
alias d="git diff"
