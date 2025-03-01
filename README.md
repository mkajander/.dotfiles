# Just some dotfiles

On a second machine, we again define the alias, clone, and checkout.
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
```bash
git clone --bare git@github.com:mkajander/.dotfiles.git $HOME/.dotfiles
```
```bash
dotfiles config --local status.showUntrackedFiles no❯ dotfiles checkout
```
