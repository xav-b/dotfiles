#!/usr/bin/env bash

set -euo pipefail

# Script to bootstrap a machine from hackliff/suit-up setup
# TODO safe trusted network pipe
# TODO Fix dna vs suit-up namings cohabitation
# usage:
#   $ # you can configure provisioning with environment variable
#   $ export DNA_TAGS="osx,hack"
#   $ export DNA_TMP_WORKSPACE="/opt"
#   $ export DNA_VCS_BRANCH="develop"
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
  WORKSPACE=${DNA_TMP_WORKSPACE:-"/tmp/suit-up"}
  BRANCH=${DNA_VCS_BRANCH:-"master"}
  readonly TAGS=${DNA_TAGS:-"all"}

  readonly PIP_INSTALL_URL="https://bootstrap.pypa.io/get-pip.py"
# }

if [ "$(basename $PWD)" == "suit-up" ]; then
  # we are already in `suit-up`, overrides
  WORKSPACE=$PWD
  BRANCH="$(git symbolic-ref -q HEAD --short)"
fi

function prepare_mac() {
# we need to agree with Apple (and ignore errors)
  xcode-select --install || true
}

function install_pip() {
  echo "installing globaly pip, so we will ask your password"
  curl "${PIP_INSTALL_URL}" | sudo python
}

function install_dna() {
  git clone https://github.com/hackliff/suit-up ${WORKSPACE}
  cd ${WORKSPACE} && git checkout ${BRANCH}
  sudo pip install -r requirements.txt
}

function main() {
  # idempotent steps
  [ $(command -v pip) ] || install_pip
  test -d ${WORKSPACE} || install_dna

  [ "$(uname)" == "Darwin" ] && prepare_mac

  cd ${WORKSPACE}

  # test setup
  ansible all -m ping -i hosts
}

main $@
