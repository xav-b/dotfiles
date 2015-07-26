# Mac OSX Provisioning

http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
https://github.com/geerlingguy/mac-dev-playbook

## Install

```sh
# install pip and ansible
curl https://bootstrap.pypa.io/get-pip.py | sudo python
sudo pip install ansible
```

## Usage

```sh
# ad-hoc commands
ansible all -m ping -i hosts
ansible-playbook -i hosts site.yml --ask-sudo-pass
```
