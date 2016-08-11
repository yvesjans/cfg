#!/bin/bash

# Check if Git is installed
if ! which git > /dev/null; then
  echo "Install git first";
  exit 1;
fi

git clone --bare https://github.com/yvesjans/cfg.git ~/.cfg

function config {
   /usr/bin/git --git-dir=~/.cfg/ --work-tree=~ $@
}

mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{};
fi;
config checkout
config config status.showUntrackedFiles no

# Install Vim Plugins
echo "Installing Vim plugins";
mkdir ~/.vim/bundle;
cd ~/.vim/bundle;
git clone https://github.com/ctrlpvim/ctrlp.vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/vim-airline/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes
git clone https://github.com/dougireton/vim-chef.git
git clone https://github.com/tpope/vim-fugitive.git
