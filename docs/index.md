# Hacker Machine Provisioning

## Installation

__Requirements__

- Python

```Sh
$ # tested in the following environment

$ python --version
Python 2.7.10

$ pip --version
pip 7.1.2
```

- [Ansible][ansible]

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


[ansible]: http://www.ansible.com/
[mkdocs]: http://www.mkdocs.org/
