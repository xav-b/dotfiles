# Mac OSX Provisioning

__Resources__

- https://github.com/donnemartin/dev-setup
- http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
- https://github.com/geerlingguy/mac-dev-playbook

## Install

```sh
# install pip and ansible
curl https://bootstrap.pypa.io/get-pip.py | sudo python
sudo pip install -U ansible
```

## Usage

```sh
# ad-hoc commands
ansible all -m ping -i hosts
ansible-playbook -i hosts site.yml --ask-sudo-pass
```

## Still manual stuff

- Remap Caps-Lock to Escape with [Seil](https://pqrs.org/osx/karabiner/seil.html.en)
- Solarized / [flat design](https://github.com/ahmetsulek/flat-terminal) Terminal

### Apps

- [Google Chrome](https://www.google.fr/chrome/browser/)
- [Dashlane](https://www.dashlane.com/fr/) - _Le meilleur gestionnaire de mots de passe et portefeuille numérique du monde_
- [Spotify](https://www.spotify.com/fr/)
- [Prey](https://preyproject.com/) - _A solid, feature packed recovery solution for your laptop, phone and tablet_
- [Atom](https://atom.io/) - _A hackable text editor for the 21st Century_
- [Virtualbox](https://www.virtualbox.org)
- [Vagrant](https://www.vagrantup.com/) - _Development environments made easy_

### App Store

- [Behance](https://www.behance.net/apps) - _Showcase & Discover Creative Work_
- [Pushbullet](https://www.pushbullet.com/) - _connects your devices, making them feel like one_
- [Noizio](http://noiz.io/) - _Just turn on the sound and allow yourself to become engulfed in the tranquil sounds of nature_
- [Letterspace](https://itunes.apple.com/fr/app/letterspace-taking-notes-made/id950145466?mt=12) - _taking notes made easy_
- [Flashlight](http://flashlight.nateparrott.com/) - _Control your Mac with a keystroke_
- [Spectacle](http://spectacleapp.com/) - _Move and resize windows with ease._
- [Cheatsheet](http://www.mediaatelier.com/CheatSheet/) - _Know your short cuts_
- [Padbury Clock](http://padbury.me/clock/) - _minimalist screensaver_
