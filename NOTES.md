# TODO

#### 2019 upgrade

- Brew: had to run `rm -f /usr/local/lib/libAliST.dylib`
- Install pyenv and pyenv-virtualenv and pyenv completions
- tmux start displays invalid options
- Link neovim init to vim
- Install Hack fonts
- Before having neovim to install bundle, needs to setup python3.6+,
  make it general and pip install neovim

- Manage dependencies between tasks/tags
- Run GoInnstallBinaries in Vim
- Reset Docker installation on Linux (beware of EE and CE now)
- Install ipython and copy ./files/ipython/
- map `vim:TagbarToggle` and other tags stuff to cool keys

- Fix Go setup => impose go1.4 and fix go1.8 compilation
- Fix Ultisnips installations
- Fix Vim auto trailing space suppression
- Fix idempotent rbenv installation
- Fix tmuxinator installation (gem is not supposed to be installed)
- Fix gnome/vim/tmux colorscheme issue

- Move away from brew when possible
- Use better tags ?

- Automate source code pro installation (or other ?)

```Bash
[ -d /usr/share/fonts/opentype ] || sudo mkdir /usr/share/fonts/opentype
sudo git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
sudo fc-cache -f -v
```
