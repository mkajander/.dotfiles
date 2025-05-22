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
brew install eza gh powerlevel10k zsh-autosuggestions zsh-syntax-highlighting bash-completion fzf fd bat tlrc thefuck zoxide azure-cli jesseduffield/lazygit/lazygit jesseduffield/lazydocker/lazydocker
```
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```
```bash
mkdir fzf-git.sh
curl https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o ./fzf-git.sh/fzf-git.sh
```

```bash
cd ${ZSH_CUSTOM1:-$ZSH/custom}/plugins
git clone https://github.com/djui/alias-tips.git --depth 1
```
