# Hacker Machine Provisioning

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Store your confiuration files and deploy them with ease on your machine,
or others, thanks to [Ansible][ansible]. Handy to manage at scale® the
setup of developer's machines or to properly organize and customize your
own setup.


## Usage

```sh
# check ansible is correctly configured for local provisioning (make check)
ansible all -m ping -i hosts

# provision your local machine
ansible-playbook -i hosts site.yml --ask-sudo-pass

# limit provisioning to tags
ansible-playbook -i hosts site.yml --tags editor
```


## Installation

If you are using a Mac, you need first to install Xcode developer tools
(running `git` for example will prompt you to do so) or the script will
abort to ask you to do that (and you will need to run it again, which is
not a big deal, granted).

```Bash
# you can personalize installation
DNA_TMP_WORKSPACE="./suit-up"
DNA_VCS_BRANCH="feat/upgrade"

curl https://raw.githubusercontent.com/xav-b/suit-up/${DNA_VCS_BRANCH}/bootstrap.sh | bash
```

You should now have [Ansible][ansible] installed and the repository
downloaded in `/tmp/suit-up`.

Go there and edit to your taste `./vars/packages.yml` (third parties
packages to be installed) and `./vars/properties.yml` where live the
settings.

Then, suit-up your machine :

```Bash
TAGS="shell,tools" make
```


## Contributing

- Python

```Sh
# tested under conda  4.2.12
conda create --name dotfiles python=3
source activate dotfiles

python --version
# Python 3.5.2 :: Continuum Analytics, Inc.

pip --version
# pip 9.0.1 from /Users/...
```

- [Ansible 2.6.4][ansible]

> App deployment, configuration management and orchestration - all from
> one system.

- [docsify][docsify]

> A magical documentation site generator.
> Simple and lightweight (~19kB gzipped)
> No statically built html files
> Multiple themes

Just run `make` to install them.


[ansible]: http://www.ansible.com/
[docsify]: https://docsify.js.org/#/
