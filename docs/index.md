# Hacker Machine Provisioning

## Installation

__Requirements__

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


## Usage

```sh
# check ansible is correctly configured for local provisioning (make check)
ansible all -m ping -i hosts

# provision your local machine
ansible-playbook -i hosts site.yml --ask-sudo-pass

# limit provisioning to tags
ansible-playbook -i hosts site.yml --tags editor
```


## TODO

- Optional neovim/vim installation


[ansible]: http://www.ansible.com/
[mkdocs]: http://www.mkdocs.org/
