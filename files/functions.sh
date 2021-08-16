#!/usr/bin/env bash
# --
# -- {{ ansible_managed }}
# --

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_"
}

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

# https://github.com/chubin/wttr.in
weather() {
  local city=${1:-Singapore}

  curl wttr.in/${city}
}

# cypher the given string. The beauty is that if you give it the resulting
# string, it will decypher it back to the original one
cypher() {
  SEED="N-ZA-Mn-za-m"
  local msg_="$@"
  echo "${msg_}" | tr 'A-Za-z' "${SEED}"
}

function cronguru() {
  # TODO convert spaces to "-" or "_"
  # supported expressions: https://crontab.guru/examples.html
  local expression="$@"
  open "https://crontab.guru/${expression}"
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0  ]; then
    open .;
  else
    open "$@";
  fi;
}

function init_pyvenv() {
  # NOTE suppose to use virtualenvwrapper over conda
  mkvirtualenv -a . -r dev-requirements.txt "$(basename $PWD)"
}

# credit https://dev.to/ricardomol/note-taking-from-the-command-line-156
# usage:
#
#     $ notes my_command -which -I -want -to remember
#     $ notes <<NOTE
# This is a very long note
# because sometimes I like
# to write explanations of
# my commands and such.
# NOTE
function note() {
  local journal="$HOME/journal.wiki"

  if [ ! -z "$1" ]; then
    echo $(date +"%Y%m%d-%H%M%S") $@  >> ${journal}
  else
    echo $(date +"%Y%m%d-%H%M%S") "$(cat)"  >> $${journal}
  fi
}

goto() {
  if [ "$1" = "heroku" ]; then
    open "https://dashboard.heroku.com/"
  elif [ "$1" = "datadog" ]; then
    open "https://app.datadoghq.com/apm/home"
  elif [ "$1" = "gh" ]; then
    local repo=${2:-""}
    open "https://github.com/${repo}"
  elif [ "$1" = "jira" ]; then
    local ticket="$2"
    if [[ -n "${ticket}" ]]; then
      open "https://acme.atlassian.net/browse/${ticket}"
    else
      open "https://acme.atlassian.net/secure/Dashboard.jspa"
    fi
  elif [ "$1" = "aws" ]; then
    local region=${2:-"eu-west-1"}
    open "https://${region}.console.aws.amazon.com/console/home?region=${region}"
  else:
    echo "unknown service: ${1}"
  fi
}

add_pyth() {
  # TODO make it idempotent by checking $PYTHONPATH
  echo "appending ${1} to ${PYTHONPATH}"
  export PYTHONPATH="${1}:$PYTHONPATH"
}

rt() {
  local project=${1:-"nose"}
  nosetests -v --with-timer --with-doctest --with-xunit --xunit-file=/tmp/${prpject}-tests.xml "$@"
}

remote() {
  command_="$1"
  hosts_="$2"
  limit_="$3"

  ansible "${hosts_}" \
    -m shell \
    -a "${command_}" \
    --limit "${limit_}" \
    --user kpler
}

_start_vipsql () {
  local query_file="$HOME/.queries.sql"

  # use standard postgres variables - with some sane defaults
  # TODO: also support full uri
  local pghost=${PGHOST:-"0.0.0.0"}
  local pgport=${PGPORT:-"5432"}
  local pguser=${PGUSER:-"postgres"}

  [[ -z "$PGPASSWORD" ]] && echo -e "[WARN] vipsql: no password set"
  [[ -z "$PGDATABASE" ]] && echo -e "[WARN] vipsql: no database set"

  # nvim "${query_file}" -c 'setlocal buftype=nofile | setlocal ft=sql | VipsqlOpenSession '"$*"
  nvim "${query_file}" \
    -c 'setlocal ft=sql | VipsqlOpenSession '"--host ${pghost} --username ${pguser} --dbname ${PGDATABASE}"
}

vipsql () {
  # execute ina  subshell to get back our current working dir
  (
    # at Kpler I used to setup the env here
    _start_vipsql "$@"
  )
}

kp() {
  # mnemonic: [K]ill [P]rocess
  # show output of "ps -ef", use [tab] to select one or multiple entries
  # press [enter] to kill selected processes and go back to the process list.
  # or press [escape] to go back to the process list. Press [escape] twice to exit completely.

  local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
    kp
  fi
}

cani() {
  ### Caniuse + FZF
  # caniuse for quick access to global support list
  # also runs the `caniuse` command if installed

  local feat=$(ciu | sort -rn | eval "fzf ${FZF_DEFAULT_OPTS} --ansi --header='[caniuse:features]'" | sed -e 's/^.*%\ *//g' | sed -e 's/   .*//g')

  if which caniuse &> /dev/null; then
    if [[ $feat ]] then; caniuse $feat; fi
  fi
}

gm() {
  git commit -m ${1}
}

# generate a qr code of your wifi endpoint
# very nice for guest people
# credit: https://feeding.cloud.geek.nz/posts/encoding-wifi-access-point-passwords-qr-code/
qr_wifi() {
  # one need to `brew install qrencode`
  local SSID="$1"
  local PASSWORD="$2"

  qrencode -o wifi.png "WIFI:T:WPA;S:${SSID};P:${PASSWORD};;"
}

alias scripts='cat package.json | jq "./scripts"'

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