# --
# -- {{ ansible_managed }}
# --

# --
# -- Shell tips
# --

alias vim='/usr/local/bin/vim'
alias ne="NVIM_LISTEN_ADDRESS=/tmp/nvim.sock nvim"
alias e="$EDITOR"

alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias cdl="cd ~/Downloads"
alias cdh="cd ~/Hack"

# Get week number
alias week='date +%V'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# --
# -- Docker tips
# --

# delete all untagged images.
alias dcleani='printf "\ndeleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# docker garbage collector by Spotify
alias dgc='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc spotify/docker-gc'

# Shellscript to delete orphaned docker volumes
# https://github.com/chadoe/docker-cleanup-volumes
alias dcleanv='printf "\ndeleting orphan volumes\n\n" && docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes'

## docker-machine/compose ------------------------------------------------------

# reset docker-compose fleet
alias dcreset='printf "\ndestroying fleet ...\n" && docker-compose stop && docker-compose rm -v'

# pretty/smart printing for small terminals
alias dlc='docker-container-list'
alias dli='docker-image-list'

# --
# -- Else
# --

alias cat='ccat'
alias rm='trash'
alias cag='clear && ag'
alias c='clear'
