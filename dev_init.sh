#! /bin/sh

## basic initialization
sudo apt-get update -y
sudo apt-get install -y build-essentials
sudo apt-get install -y git gcc zsh

## neovim installation and initialization
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update -y
sudo apt-get install -y neovim
mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim ~/.vimrc
echo "set runtimepath+=~/.vim,~/.vim/after" >> ~/.config/nvim/init.vim
echo "set packpath+=~/.vim" >> ~/.config/nvim/init.vim
source ~/.vimrc

## install zsh
sudo chsh -s $(which zsh)
echo $SHELL

## install oh-my-zsh
sudo apt-get install -y curl wget
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## install nerd-font -> Caskaydia Cove, Ubuntu, Ubuntu Mono
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh CaskaydiaCove, Ubuntu, UbuntuMono
cd ~
rm -rf nerd-fonts

## vim bundle installation
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd ~
git clone https://github.com/inniestar97/vimrc.git
cp -f ~/vimrc/vimrc ~/.vimrc
cd ~
rm -rf vimrc
vim +PluginInstall +qall
source ~/.vimrc

### Checked docker already exist
## need to check docker run without sudo
#if ! command -v docker &> /dev/null
#then
#	echo "docker could not be found"
#	# install docker
#	sudo apt-get -y update
#	sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
#	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#	sudo apt-get -y update
#	sudo apt-get install -y docker-ce docker-ce-cli containerd.io
#	sudo systemctl status docker
#	sudo docker run hello-world
#fi
