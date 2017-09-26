#!/usr/bin/env bash
# --
# -- {{ ansible_managed }}
# --

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
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
