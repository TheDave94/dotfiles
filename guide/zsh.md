### Installing Oh-My-Zsh

#### Run the Installer

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Getting the plugins
```shell
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```

#### Adding the plugins to .zshrc
```shell
nano ~/.zshrc
```

```shell
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

# Plugin Setup
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a8a8a8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC="1"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
```

* Th part of the instructions is not necessary and can be ignored. This is only about advanced styling.

#### Adding powerlevel10k
```shell
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

#### Styling ls & la
```shell
yay -S --noconfirm ruby-colorls
```

#### Adding ruby-colorls to .zshrc
```shell
nano ~/.zshrc
```

```shell
# Colorls
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"<
    alias la="colorls -al"
fi
```