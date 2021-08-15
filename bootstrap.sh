#!/usr/bin/env bash

set -euo pipefail

# Script to bootstrap a machine from xav-b/dotfiles setup
#
# TODO safe trusted network pipe
# TODO install Python if not here
#
# usage:
#   $ # you can configure provisioning with environment variable
#   $ export DOTFILES_TMP_WORKSPACE="/opt"
#   $ export DOTFILES_VCS_BRANCH="develop"
#   $ curl ... | bash
#
# test environment:
#   $ python --version
#   python 2.7.10
#   $ pip --version
#   pip 9.0.1
#
# NOTE should we prefer an installation per user ?

# var {
  # customisable
  WORKSPACE=${DOTFILES_TMP_WORKSPACE:-"/tmp/dotfiles"}
  BRANCH=${DOTFILES_VCS_BRANCH:-"master"}

  readonly PIP_INSTALL_URL="https://bootstrap.pypa.io/get-pip.py"
# }

if [ "$(basename $PWD)" == "dotfiles" ]; then
  # we are already in `dotfiles`, overrides
  WORKSPACE=$PWD
  BRANCH="$(git symbolic-ref -q HEAD --short)"
fi

function prepare_mac() {
  # we need to agree with Apple (and ignore errors)
  xcode-select --install || true
}

# https://pip.pypa.io/en/stable/installation/
function install_pip() {
  echo "installing globaly pip, so we will ask your password"
  curl "${PIP_INSTALL_URL}" | sudo python
}

function install_dotfiles() {
  git clone "https://github.com/xav-b/dotfiles" "${WORKSPACE}"
  cd ${WORKSPACE} && git checkout ${BRANCH}
  sudo pip install --user -r requirements.txt

  # make `--user` binaries available. Since it may conflict later on with
  # virtualenv binaries, this is only setup here, but not meant to be persisted
  # in theshell configuration
  python -c 'import site; print(site.USER_BASE + "/bin")'
  export PATH=$PY_USER_BIN:$PATH
}

function main() {
  # idempotent steps
  # TODO
  [ $(command -v pip) ] || install_pip
  test -d ${WORKSPACE} || install_dotfiles

  [ "$(uname)" == "Darwin" ] && prepare_mac

  cd ${WORKSPACE}

  # test setup
  make check
}

main $@
