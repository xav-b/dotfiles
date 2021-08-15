# --
# -- {{ ansible_managed }}
# --

# --
# -- Shell tips
# --

# use custom installation path
# alias vim='/usr/local/bin/vim'
# alias ne="NVIM_LISTEN_ADDRESS=/tmp/nvim.sock nvim"
alias ne="nvim"
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

alias rm='trash'
alias c='clear'

## Summary for args to less:
# less(1)
#   -M (-M or --LONG-PROMPT) Prompt very verbosely
#   -I (-I or --IGNORE-CASE) Searches with '/' ignore case
#   -R (-R or --RAW-CONTROL-CHARS) For handling ANSI colors
#   -F (-F or --quit-if-one-screen) Auto exit if <1 screen
#   -X (-X or --no-init) Disable termcap init & deinit
alias cag='clear && ag --smart-case --pager="less -MIRFX"'

alias _="sudo"

alias q='exit'
alias h='history'

# Language aliases
alias rb='ruby'
alias py='python'
alias ipy='ipython'

alias ni='npm install'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias nr='npm run'

# OSX
# TODO check OS
# Get rid of those pesky .DS_Store files recursively
alias dsclean='find . -type f -name .DS_Store -delete'
# Flush your dns cache
alias flush='dscacheutil -flushcache'
# Mute/Unmute the system volume. Plays nice with all other volume settings.
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"
# Pin to the tail of long commands for an audible alert after long processes
## curl http://downloads.com/hugefile.zip; lmk
alias lmk="say 'Process complete.'"

# credits: https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --preview 'bat {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
alias zz="z | fzf"

alias ap="ansible-playbook"

# useful goto url
# https://www.gizmodo.com.au/2018/09/10-hidden-urls-to-help-you-rule-the-web/
alias goto_mytrack='open https://www.google.com/maps/timeline?hl=en&authuser=0&ei=6mDLWvKWCoK-gge4346ACA%3A8&ved=1t%3A17706&pb'
alias goto_wl='open https://www.youtube.com/playlist?list=WL'

alias darksky='open https://darksky.net/forecast/1.304,103.849/ca12/en'

# stolen from https://darrenburns.net/posts/tools/
alias record='svg-term --out ~/tmp/screencast.svg --padding 18 --height 8 --width 80'

# note installed
# alias ping='prettyping --nolegend'

alias f='fff'

# similar to https://github.com/tldr-pages/tldr
cheat() {
  curl "cht.sh/$1"
}

# stolen from https://news.ycombinator.com/item?id=18898523
cleanchrome() {
  chromium --user-data-dir "$(mktemp -d)"
}

alias vip='nvim +PluginInstall +qall'
alias vup='nvim +PluginUpdate'
alias vv='$EDITOR ~/.vimrc'
alias zz='$EDITOR ~/.zshrc'
alias gdc='git diff --cached'