# Hacker Machine Provisioning

Store your confiuration files and deploy them with ease on your machine,
or others, thanks to [Ansible][ansible]. Handy to manage at scale the
setup of developer's machines or to preoperly organize and customize
your own setuP.


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

```Bash
$ DNA_VCS_BRANCH="feat/upgrade"
$ curl https://raw.githubusercontent.com/hackliff/suit-up/feat/upgrade/bootstrap.sh | bash
```

You should have [Ansible][ansible] installed and the repository
downloaded in `/tmp/suit-up`.

Go there and edit to your taste `./vars/packages.yml` (third parties
packages to be installed) and `./vars/properties.yml` where live the
settings.

Then, suit-up your machine :

```Bash
$ TAGS="shell,tools" make
```


## Contributing

- Python

```Sh
$ # tested under conda virtualenv
$ conda --version
conda 4.2.12
$ conda create --name dotfiles python=3
$ source activate dotfiles

$ python --version
Python 3.5.2 :: Continuum Analytics, Inc.

$ pip --version
pip 9.0.1 from /Users/...
```

- [Ansible 2.2.0.0][ansible]

> App deployment, configuration management and orchestration - all from one
> system.

- [Mkdocs][mkdocs]

> Fast, simple and downright gorgeous static site generator that's geared
> towards building project documentation. 

Just run `make` to install them.


[ansible]: http://www.ansible.com/
[mkdocs]: http://www.mkdocs.org/
