#! /bin/bash

# Script to install my everyday terminal dependencies and shell settings on a new mac

#TODO:
# Debian version
# fix set hostname - complains about scutil check yosemite syntax
# make echo look alike on both 10.9 and 10.10


##########  DEFAULT INSTALL CONFIG  #############

#brew software to be installed
BREWS="coreutils wget z caskroom/cask/brew-cask node gnu-sed go hg"

# pip packages to be installed
PIPS="virtualenv setuptools autoenv"

#cask software to be installed
CASKS="google-chrome google-drive dropbox alfred spotify sublime-text thunderbird slack iterm2 divvy caffeine deluge vlc" 

#files to symlink into homedir
FILES="zshrc vimrc scripts"

##################################################

MAIN_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#check if user provided own config
if [[ $1 == -c ]]; then
    CONFIG_FILE=$2
fi

if [[ -f $CONFIG_FILE ]]; then
    source $CONFIG_FILE
fi

# Colors
red="\033[0;31m"
yellow="\033[0;33m"
green="\033[0;32m"
purple="\033[0;35m"
NC="\033[0m"

echo -e "${green}###################################"
echo -e "#  Installation script to set up  #"
echo -e "#   a fresh OS X installation     #"
echo -e "###################################"
echo ""
echo -e "This installation will install the following software:"
echo -e "------------------------------------------------------"
echo -e "Terminal apps/Homebrew/pip"
for pip in $PIPS; do
    echo -e "-- "$pip
done
if [ "$(uname)" == "Darwin" ]; then
    for brew in $BREWS; do
        echo -e "-- "$brew
    done
    echo -e ""
    echo -e "Desktop applications (with cask)"
    for cask in $CASKS; do
        echo -e "-- "$cask
    done
fi
echo -e "------------------------------------------------------"
echo -e "To customize which applications to install, run the script with -c followed by the path to your config file."
echo -e "See the example file, for more information."

echo ""
echo -e "${red}Make sure you are connected to the internet before you procede!${NC}"
echo ""
#check if user want to continue
read -p "Do you want to procede with the installation? (y/n)" -n 1 response </dev/tty
if [[ ! $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Exiting installation..."
    exit 0
fi

# Get sudo from user
echo -e "${yellow}You might need to input your sudo password${NC}"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Change hostname
# read -p "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)" response
# if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
#   echo "What would you like it to be?"
#   read COMPUTER_NAME
#   sudo scutil --set ComputerName $COMPUTER_NAME
#   sudo scutil --set HostName $COMPUTER_NAME
#   sudo scutil --set LocalHostName $COMPUTER_NAME
#   sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
#   echo -e "${green}Computer name was changed to $COMPUTER_NAME${NC}"
# fi

if [ "$(uname)" == "Darwin" ]; then

    #Install homebrew
    echo "Checking if Homebrew is installed.."
    if ! which brew > /dev/null; then
        echo -e "${yellow}Homebrew not installed. Installing now..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo -e "Running brew doctor...${NC}"
        brew doctor
        echo -e "${green}OK${NC}"
    else
        echo -e "${green}Homebrew is already installed.${NC}"
    fi

    #Install homebrew packages
    echo "Verifying that all brew packages are installed.."
    brew install ${BREWS}
    echo -e "${green}OK${NC}"

		#Set option for cask, making sure app symlinks are put in /Applications
		export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    #Install desktop software
    echo "Verifying that all cask packages are installed.."
    brew cask install ${CASKS}
    echo -e "${green}OK${NC}"
fi

if [ "$(uname)" == "Linux" ]; then
    #check is curl is installed
    echo -e "${yellow}Checking if curl is installed..${NC}"
    if ! which curl > /dev/null; then
    	echo -e "${yellow}Curl not installed. Installing now...${NC}"
    	sudo apt-get -y install curl
    	echo -e "${green}OK${NC}"
    else
    	echo -e "${green}Curl is already installed.${NC}"
    fi

    #check if zsh is installed
    echo -e "${yellow}Checking if ZSH is installed..${NC}"
    if ! which zsh > /dev/null; then
        echo -e "${yellow}ZSH not installed. Installing now...${NC}"
        sudo apt-get -y install zsh
        echo -e "${green}OK${NC}"
    else
        echo -e "${green}ZSH is already installed.${NC}"
    fi
fi

#Install zsh and oh-my-zsh
echo -e "${yellow}Checking if oh-my-zsh is installed.. ${NC}"
if [ ! -d ~/.oh-my-zsh ]; then
    echo -e "${yellow}Oh-My-Zsh not installed. Installing now...${NC}"
    curl -L http://install.ohmyz.sh | sh
    echo -e "${green}OK${NC}"
else
    echo -e "${yellow}Oh-My-Zsh is already installed.${NC}"
fi

# Syntax highlighting plugin
echo -e "${yellow}Checking if syntax highlighting is installed.."
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    echo -e "Syntax highlighting not installed. Installing now...${NC}"
    cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    cd $MAIN_DIR
    echo -e "${green}OK${NC}"

else
    echo -e "${green}oh-my-zsh already installed${NC}"
fi

# virtualenv prompt plugin
echo -e "${yellow}Checking if virtualenv-prompt is installed.."
if [ ! -d ~/.oh-my-zsh/custom/plugins/oh-my-zsh-virtualenv-prompt ]; then
    echo -e "virtualenv-prompt not installed. Installing now...${NC}"
    cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/tonyseek/oh-my-zsh-virtualenv-prompt.git virtualenv-prompt
    cd $MAIN_DIR
    echo -e "${green}OK${NC}"

else
    echo -e "${green}virtualenv-prompt already installed${NC}"
fi

# Install custom pygmalion-theme
echo -e "${yellow}Checking if custom pygmalion-theme is installed.."
if [ ! -f ~/.oh-my-zsh/custom/themes/pygmalion.zsh-theme ]; then
    echo -e "custom pygmalion-theme not installed. Installing now...${NC}"
    if [[ ! -d ~/.oh-my-zsh/custom/themes ]]; then
        mkdir -p ~/.oh-my-zsh/custom/themes
    fi
    ln -s $MAIN_DIR/setup/pygmalion.zsh-theme ~/.oh-my-zsh/custom/themes/pygmalion.zsh-theme
    echo -e "${green}OK${NC}"

else
    echo -e "${green}custom pygmalion-theme already installed${NC}"
fi

# Create symbolic link for variables in .oh-my-zsh/custom
echo -e "Creating symbolic link for environment variables"
if [ ! -f ~/.oh-my-zsh/custom/variables.zsh ]; then
	ln -s $MAIN_DIR/setup/variables.zsh ~/.oh-my-zsh/custom/variables.zsh
  echo -e "${green}OK${NC}"
fi

#install pip
echo "Checking if Pip is installed.."
if ! which pip > /dev/null; then
    echo -e "${yellow}Pip not installed. Installing now...${NC}"
    curl -O  https://bootstrap.pypa.io/get-pip.py
		sudo python get-pip.py
		rm get-pip.py
    echo -e "${green}OK${NC}"
else
    echo -e "${green}Pip is already installed.${NC}"
fi

#install pip packages
echo "Verifying that all pip packages are installed."
sudo pip install ${PIPS}
echo -e "${green}OK${NC}"

if [ "$(uname)" == "Darwin" ]; then

    # Do OS X modifications
    echo "Doing OS X modifications"

    # Display full POSIX path as Finder window title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # Finder: allow text selection in Quick Look
    defaults write com.apple.finder QLEnableTextSelection -bool true

    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Expanding the save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Use column view in all Finder windows by default
    defaults write com.apple.finder FXPreferredViewStyle Clmv

    # Prevent Time Machine from prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Disable local Time Machine backups (This can take up a ton of SSD space on <128GB SSDs)
    hash tmutil &> /dev/null && sudo tmutil disablelocal

    # Disable the all too sensitive backswipe in chrome
    defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
    defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

    #Set colortheme in iterm2
    read -p "Do you want to change the color theme in iterm2 to Solarize? (y/n)" response </dev/tty
    if [[  $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        if [[ -f ~/Library/Preferences/com.googlecode.iterm2.plist ]]; then
            mv ~/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist.old
        fi    
        cp $MAIN_DIR/setup/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
        plutil -convert binary1 ~/Library/Preferences/com.googlecode.iterm2.plist
        defaults read com.googlecode.iterm2
        echo -e "${green}iTerm2 is now solarized!${NC}"
    fi
fi

# Make symlinks for zshrc, dircolors
current_time=$(date "+%Y-%m-%d_%H:%M:%S")

read -p "Do you want to put symlinks for your dotfiles in the your home dir? (y/n)" response </dev/tty
if [[  $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    mkdir -p ~/dotfiles_${current_time}
    for file in $FILES; do
        mv ~/.$file ~/dotfiles_${current_time}/
        echo "Creating symlink to $file in home directory."
        ln -s $MAIN_DIR/$file ~/.$file
    done
    echo -e "${green}Symlinks created!${NC}"
fi

# Put host_variables file in oh-my-zsh dir if not present
if [[ ! -f ~/.host_variables ]]; then
    cp $MAIN_DIR/setup/host_variables ~/.host_variables
fi

# symlink solarized vim theme
if [[ ! -f ~/.vim/colors/solarized.vim ]]; then
    mkdir -p ~/.vim/colors/
    ln -s $MAIN_DIR/setup/solarized.vim ~/.vim/colors/solarized.vim
fi

if [ "$(uname)" == "Darwin" ]; then
    #Ask user for reboot
    echo "The computer needs to be rebooted before all the changes will take effect.${yellow}"
    read -p "Do you want to reboot now? (y/n)" response </dev/tty
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${NC}Rebooting..."
        sudo shutdown -r now
    else
        echo -e "${green}Installation is finished. Please restart as soon as possible.${NC}"
    fi
else
    echo -e "${green}Installation is finished. Please open a new session for all changes to take affect.${NC}"
fi
