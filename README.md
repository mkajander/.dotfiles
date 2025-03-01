# Just some dotfiles

On a second machine.  
[Install zsh and set as default shell](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
```bash
git clone --bare git@github.com:mkajander/.dotfiles.git $HOME/.dotfiles
```
```bash
dotfiles config --local status.showUntrackedFiles no
```
```bash
dotfiles checkout
```
```bash
brew install eza gh powerlevel10k zsh-autosuggestions zsh-syntax-highlighting bash-completion fzf fd bat tlrc thefuck zoxide
```
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```
