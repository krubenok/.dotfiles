#!/bin/sh
# "$OSTYPE" == "freebsd"* for BSD based things like freenas

# Check for Oh My Zsh and install if we don't have it
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh not detected... installing"
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
    echo "Oh My Zsh isntalled... continuing"
else
    echo "Oh My Zsh is already installed... skipping"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sw $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Check for Homebrew and install if we don't have it
if [[ "$OSTYPE" == "darwin"* || "$OSTYPE" == "linux-gnu"* ]]; then
    if test ! $(which brew); then
        echo "brew not detected... installing"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "brew isntalled... continuing"
    else
        echo "brew is already installed... skipping"
    fi
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

    echo "Running brew update & installing bundles..."
    brew update

    # Install all our dependencies with bundle (See Brewfile)
    brew tap homebrew/bundle
    brew tap superatomic/bundle-extensions
    # brew bundle --file ./Brewfile
fi

# Setup Git and Repos Folders
echo "Setting up Git and Repos folders..."
rm -rf $HOME/.gitconfig
ln -sw $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
mkdir -p $HOME/Developer/Personal
mkdir -p $HOME/Developer/Work

# Symlink the Mackup config file to the home directory
# ln -s ./.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
# source ./.macos

# If on macOS, wait for the user to create a new ssh key with secretive and paste the file path to the public key that should be used. set that to be an export in .zshrc
# use the `copyssh` alias to copy the public key to the clipboard and share the link to the github thing where I can upload my new ssh key
