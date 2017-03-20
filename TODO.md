# TODO

- Add `ccat` installation
- Add `trash` installation
- Move away from brew when possible
- Add another local file sourced by zshrc
- Manage dependencies between tasks/tags
- Run GoInnstallBinaries in Vim

- Fix `gvm` with go1.8 installation
- Fix auto-zsh shell (both platforms)
- Fix vim plugins installation
- Fix Ultisnips installations
- Fix Vim auto trailing space suppression
- Fix idempotent rbenv installation
- Fix Docker installation
- Fix tmuxinator installation (gem is not supposed to be installed)
- Fix gnome/vim/tmux colorscheme issue

- Automate Apps installation thanks to cask ?
- Use better tags ?

- Automate source code pro installation (or other ?)

```Bash
[ -d /usr/share/fonts/opentype ] || sudo mkdir /usr/share/fonts/opentype
sudo git clone https://github.com/adobe-fonts/source-code-pro.git /usr/share/fonts/opentype/scp
sudo fc-cache -f -v
```
