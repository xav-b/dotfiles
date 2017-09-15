# TODO

- Add `ccat` installation
- Add `trash` installation
- Move away from brew when possible
- Add another local file sourced by zshrc
- Manage dependencies between tasks/tags
- Run GoInnstallBinaries in Vim
- Reset Docker installation on Linux (beware of EE and CE now)
- Install ipython and copy ./files/ipython/
- Install `import better_exceptions`
- map `vim:TagbarToggle` and other tags stuff to cool keys

- Fix Go setup => impose go1.4 and fix go1.8 compilation
- Fix Ultisnips installations
- Fix Vim auto trailing space suppression
- Fix idempotent rbenv installation
- Fix tmuxinator installation (gem is not supposed to be installed)
- Fix gnome/vim/tmux colorscheme issue

- Use better tags ?

- Automate source code pro installation (or other ?)

```Bash
[ -d /usr/share/fonts/opentype ] || sudo mkdir /usr/share/fonts/opentype
sudo git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
sudo fc-cache -f -v
```
