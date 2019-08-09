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

# cypher the given string. The beauty is that if you give it the resulting
# string, it will decypher it back to the original one
crypt-that () {
  SEED="N-ZA-Mn-za-m"
  local msg_="$@"
  echo "${msg_}" | tr 'A-Za-z' "${SEED}"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
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
    open "https://dashboard.heroku.com/teams/kpler/apps"
  elif [ "$1" = "datadog" ]; then
    open "https://app.datadoghq.com/apm/home"
  elif [ "$1" = "gh" ]; then
    local repo=${2:-""}
    open "https://github.com/Kpler/${repo}"
  elif [ "$1" = "sentry" ]; then
    open "https://sentry.io/kpler"
  elif [ "$1" = "es" ]; then
    open "https://cloud.elastic.co/#clusters/eu-west-1/e3cb79689a0073a3cca03fc9a5e35e56/overview/"
  elif [ "$1" = "jira" ]; then
    local ticket="$2"
    if [[ -n "${ticket}" ]]; then
      open "https://kpler1.atlassian.net/browse/${ticket}"
    else
      open "https://kpler1.atlassian.net/secure/Dashboard.jspa"
    fi
  elif [ "$1" = "aws" ]; then
    local region=${2:-"eu-west-1"}
    open "https://${region}.console.aws.amazon.com/console/home?region=${region}"
  elif [ "$1" = "ops" ]; then
    open "https://app.opsgenie.com/alert/V2#/alert-genie"
  elif [ "$1" = "ci" ]; then
    local project="$2"
    # TODO change Kpler
    open "https://circleci.com/gh/Kpler/${project}"
  else:
    echo "unknown service: ${1}"
  fi
}

add_pyth() {
  # TODO make it idempotent by checking $PYTHONPATH
  echo "appending ${1} to ${PYTHONPATH}"
  export PYTHONPATH="${1}:$PYTHONPATH"
}

rt () {
  local project=${1:-"nose"}
  nosetests -v --with-timer --with-doctest --with-xunit --xunit-file=/tmp/${prpject}-tests.xml "$@"
}

remote () {
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
  # TODO use a decent standard path
  local query_file="$HOME/Hack/queries.sql"

  # TODO make something more generic
  local commodity=${1:-"lng"}
  local platform=${2:-"production"}
  local database="${commodity}"

  local username=$(decrypt_param "kpler_etl_db_user")
  local password=$(decrypt_param "kpler_etl_db_pass")

  if [[ "${commodity}" == "oil" ]]; then
    database="${commodity}_testing"
  fi

  # TODO hide this
  export PGPASSWORD="${password}"

  # nvim "${query_file}" -c 'setlocal buftype=nofile | setlocal ft=sql | VipsqlOpenSession '"$*"
  nvim "${query_file}" \
    -c 'setlocal ft=sql | VipsqlOpenSession '"-h $(_pg_host ${commodity} ${platform}) -U ${username} -d ${database}"
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

alias vip='vim +PluginInstall +qall'

gm() {
  git commit -m ${1}
}
