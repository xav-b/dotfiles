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
CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" pyenv install -v 3.5.6

pyenv virtualenv 3.5.6 suit-up
# tested under pyenv 1.2.9
pyenv activate suit-up

python --version
# Python 3.5.6

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

### Manual things

- Install trash
- Compile go1.4 before installing qny superior versions
- Copy `neovim-init` to `˜/.config/mvim/init.vim`
- Get Golang started

### Fixme

- GVM installation on MacOSX
- fzf install the search helper only for bash
- tmux looks ugly
- Fuck is not installed nor configured (`eval $(thefuck --alias)`)
- global pip package missing: neovim, thefuck
- `trash-cli` is not installed

---

<img
  width="50px"
  alt="profile"
  src="https://it.gravatar.com/userimage/51922459/c5e521b1b03eabff18b3763bcdfef8ff.jpeg"
  align="right" />

### 💖 Shameless plug

> Hey nice to meet you, I'm [Xavier](www.xav-b.fr) and I maintain this project.

<a href="https://www.buymeacoffee.com/xavb" target="_blank"><img src="https://bmc-cdn.nyc3.digitaloceanspaces.com/BMC-button-images/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>
&nbsp;&nbsp;&nbsp;
<a
  href="https://www.codementor.io/xavierbruhiere?utm_source=github&utm_medium=button&utm_term=xavierbruhiere&utm_campaign=github">
<img
      src="https://cdn.codementor.io/badges/i_am_a_codementor_dark.svg"
      alt="I am a codementor"
      style="max-width:100%"/>
</a>
&nbsp;&nbsp;&nbsp;
<a target="_blank" href="https://tinyletter.com/Xav">
<img
      width="38px"
      alt="subscribe"
      src="https://newvitruvian.com/images/svg-buttons-web-1.png"/>
</a>
&nbsp;&nbsp;&nbsp;

<div align="center">
	<br>
	<br>
	<br>
	<br>
  <sub>Suit-up your system.
	<br/>Built by
  <a href="http://www.xav-b.fr">Xavier Bruhiere</a> and
  <a href="https://github.com/xav-b/mockingbird/graphs/contributors">
    contributors
  </a>
	<br/>with a </i>💻<i> and some </i>🍣
</div>

<p align="center">
	<br>
	<br>
	<img
		src="https://github.com/xav-b/on-a-budget/blob/master/assets/vespa.svg"
		width="48"
		alt="TIC logo" />
	<br>
	<br>
</p>

[ansible]: http://www.ansible.com/
[docsify]: https://docsify.js.org/#/
