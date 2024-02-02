#! /bin/sh

_PLATFORM=`uname`
_SCRIPT_DIR_PATH=$(dirname $0)/

if [ -z ${_PLATFORM} ] ; then
	echo "There's no Platform"
	exit
fi

## -----------------------------------------------
## ------------- basic initialization ------------
## -----------------------------------------------
if [ ${_PLATFORM} == "Linux" ] ; then

	sudo apt-get update -y
	sudo apt-get install -y build-essentials
	sudo apt-get install -y git gcc

elif [ ${_PLATFORM} == "Darwin" ] ; then

	/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install gcc

else
	echo "Not unix platform"
fi

## -----------------------------------------------
## --- neovim installation and initialization ----
## -----------------------------------------------
if [ ${_PLATFORM} == "Linux" ] ; then

	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt-get update -y
	sudo apt-get install -y neovim

elif [ ${_PLATFORM} == "Darwin" ] ; then

	brew install nvim

else
	:
fi
mkdir ${HOME}/.config/nvim
touch ${HOME}/.config/nvim/init.vim ~/.vimrc
echo "set runtimepath+=~/.vim,~/.vim/after" >> ${HOME}/.config/nvim/init.vim
echo "set packpath+=~/.vim" >> ${HOME}/.config/nvim/init.vim
echo "source ~/.vimrc" >> ${HOME}/.config/nvim/init.vim

## -----------------------------------------------
## ---------------- install zsh ------------------
## -----------------------------------------------
if [ ${_PLATFORM} == "Linux" ] ; then

	sudo apt-get install -y zsh
	sudo chsh -s $(which zsh)
	echo $SHELL

elif [ ${_PLATFORM} == "Darwin" ] ; then
	:
else
	:
fi

## -----------------------------------------------
## ------------- install oh-my-zsh ---------------
## -----------------------------------------------
if [ ${_PLATFORM} == "Linux" ] ; then

	sudo apt-get install -y curl
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

elif [ ${_PLATFORM} == "Darwin" ] ; then
	:
else
	:
fi

## -----------------------------------------------
## ------------- install nerd-font ---------------
## -----------------------------------------------
if [ ${_PLATFORM} == "Linux" ] ; then

	# Caskaydia Cover, Ubuntu, Ubuntu Mono
	git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
	cd nerd-fonts
	./install.sh CaskaydiaCove, Ubuntu, UbuntuMono
	cd ${HOME}
	rm -rf ${HOME}/nerd-fonts

elif [ ${_PLATFORM} == "Darwin" ] ; then
	# Caskaydia Cover
	brew tap homebrew/cask-fonts
	brew install font-caskaydia-cove-nerd-font
	
else
	:
fi

## -----------------------------------------------
## ----------- vim-plug installation -------------
## -----------------------------------------------
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
			 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp -f ${_SCRIPT_DIR_PATH}/vimrc ${HOME}/.vimrc
rm -rf ${HOME}/vimrc
cd ${HOME}
vim +PlugInstall +qall

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

