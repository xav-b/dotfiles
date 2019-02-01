# --
# -- {{ ansible_managed }}
# --

# --
# -- Shell tips
# --

# use custom installation path
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
alias c='clear'

## -----------------------------------------------------------------------------
## Custom functions

try_stuff () {
  local project=${1:-"hack"}
  local tmp_path=${2:-/tmp}
  local rand_id="$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32)"

  local tmp_project_path="${tmp_path}/${project}.${rand_id}.sandbox"

  mkdir ${tmp_project_path} && cd ${tmp_project_path}
  printf "temporary hack space ready at $PWD"
}

tns () {
  # TODO if not $1, just tmux
  tmux new -s ${1:-"workbench"}
}

shellrc () {
  echo "$HOME/.$(basename $SHELL)rc"
}

na () {
  local alias_mapping="$@"
  echo -e "\nalias ${alias_mapping}\n" >> $(shellrc)
}

pipsave () {
  local pypkg="$1"
  local requirements="${2}requirements.txt"

  test -f ${requirements} || echo -e "# tested under $(python --version)" > ${requirements}

  echo "\n --> installing ${pypkg}..."
  pip install -U ${pypkg}

  # TODO remove it if already here ?
  local pkg_pinned="$(pip freeze |grep -i ${pypkg})"
  echo "\n --> dumping ${pkg_pinned} into ${requirements}"
  echo "${pkg_pinned}" >> "${requirements}"

  cat ${requirements}
  echo
}

# push local content to remote directory
# example sync_push () {
  # local CEREBRO_PRE_HOST="54.84.12.222"
  # local AWS_HOST=${CEREBRO_PRE_HOST}
  # local AWS_USER="ec2-user"
  # local DESTINATION="/home/${AWS_USER}/workspace"

  # _remote_sync "$(pwd)" "${AWS_USER}@${AWS_HOST}:${DESTINATION}"
# }
remote_sync() {
  local source_path=${1:-"$PWD"}
  local dest_path="$2"
  # TODO replace by ssh-agent
  local ssh_key=${3:-"$HOME/.ssh/id_rsa"}

  local RSYNC_SSH_OPTS="ssh -i ${ssh_key} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

  rsync \
      --archive \
      --verbose \
      --compress \
      --progress \
      --recursive \
      -e ${RSYNC_SSH_OPTS} \
      ${source_path} ${dest_path}
}

scala () {
  local entrypoint=${1:-"amm"}
  local name=${2:-"scala"}
  local image="local/scala:latest"
  local workdir=/app

	docker run --name ${name} \
	  -it --rm -v $(PWD):${workdir} -w ${workdir} \
	  ${image} ${entrypoint}
}

# https://github.com/chubin/wttr.in
weather() {
  local city=${1:-Paris}

  curl wttr.in/${city}
}

SEED="N-ZA-Mn-za-m"

# cypher and decypher strings
cypher () {
  local msg_="$@"
  echo "${msg_}" | tr 'A-Za-z' "${SEED}"
}


function cronguru() {
  # TODO convert spaces to "-" or "_"
  # supported expressions: https://crontab.guru/examples.html
  local expression="$@"
  open "https://crontab.guru/${expression}"
}

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
alias c='clear'

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

explain () {
  about 'explain any bash command via mankier.com manpage API'
  param '1: Name of the command to explain'
  example '$ explain                # interactive mode. Type commands to explain in REPL'
  example '$ explain 'cmd -o | ...' # one quoted command to explain it.'
  group 'explain'

  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

compare_master() {
  local master_url="https://github.$(git config remote.origin.url | cut -f2 -d. | tr ':' /)"
  local branch="$(git symbolic-ref --short HEAD)"

  open "${master_url}/compare/${branch}"
}

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

alias weather='open https://darksky.net/forecast/1.304,103.849/ca12/en'
# https://github.com/chubin/wttr.in
weather_cli() {
  local city=${1:-"Paris""}

  curl wttr.in/${city}
}

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
