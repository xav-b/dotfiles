# --
# -- {{ ansible_managed }}
# --

# --
# -- Shell tips
# --

#alias vim='/usr/local/bin/vim'
alias e="$EDITOR"
alias copy_ip='curl -Ss icanhazip.com | pbcopy'

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

# use custom installation path
alias vim='/usr/local/bin/vim'

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
