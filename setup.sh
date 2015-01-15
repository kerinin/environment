#! /usr/bin/env bash

echo "SETTING UP ALL THE THINGS!!!"
echo "SSH keys should already be installed in .ssh (if you're going to do that)"

command_exists () {
  type "$1" &> /dev/null ;
}

symlink_or_backup () {
  if [ -L $1 ] && [ "$(readlink $1)" = "$2" ]; then
    echo "$1 already setup"
  elif [ -L $1 ]; then
    echo "$1 exists, but points at $(readlink $1) - pointing at $2"
    rm $1
    ln -s $2 $1
  elif [ -d $1 ]; then
    echo "$1 exists and is a directory - moving to $1_back and symlinking to $2"
    mv "$1" "$1_back"
    ln -s $2 $1
  elif [ -f $1 ]; then
    echo "$1 exists and is a file - backing up to $1_back and symlinking to $2"
    mv "$1" "$1_back"
    ln -s $2 $1
  else
    echo "Setting up $1"
    ln -s $2 $1
  fi
}

install_stuff () {
  if ! command_exists $1; then
    echo -n "Install $1?" >&2
    read yn
    case $yn in
      [Yy] ) echo "Installing $1"; eval $2;;
      * ) echo "Not installing $1";;
    esac
  else
    echo "$1 already installed"
  fi
}

cd

echo "---> Installing software:"
if [[ -n $INSTALL && `uname` == Darwin ]]; then
  install_stuff brew 'ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'
  install_stuff git 'brew install git'
  install_stuff mysql 'brew install mysql'
  install_stuff redis-server 'brew install redis'
  install_stuff memcached 'brew install memcached'
  install_stuff rbenv 'brew install rbenv'
  install_stuff ruby-build 'brew install ruby-build'
  install_stuff wget 'brew install wget'
  install_stuff ag 'brew install the_silver_searcher'
  brew install vim && sudo mv /usr/bin/vim /usr/bin/vim.apple && sudo ln -s /usr/local/bin/vim /usr/bin/vim
elif [[ -n $INSTALL && `uname` == Linux ]]; then
  install_stuff git 'sudo apt-get install git'
  install_stuff mysql 'sudo apt-get install msyql'
  install_stuff redis 'sudo apt-get install redis'
  install_stuff memcached 'sudo apt-get install memcached'
  install_stuff rbenv 'sudo apt-get install rbenv'
  install_stuff ruby-build 'sudo apt-get install ruby-build'
  install_stuff wget 'sudo apt-get  install wget'
  install_stuff ag 'sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev; git clone git://github.com/ggreer/the_silver_searcher.git; cd .the_silver_searcher; ./build.sh; sudo make install; cd'
  install_stuff zsh 'sudo apt-get install zsh'
else
  echo "Either I don't recognize your OS ($(uname)) or you didn't set \$INSTALL=Y - not trying to install stuff"
fi

if ! command_exists git; then
  echo "Git not installed, aborting"
  return
fi

echo "---> Cloning environment repo:"
if ! [ -d environment ]; then
  if git clone git@github.com:kerinin/environment.git; then
    echo "Cloned environment repo with commit access"
  else
    git clone git://github.com/kerinin/environment.git
    echo "Cloned environment without commit access"
  fi
else
  echo "environment already cloned, fetching master"
  cd environment
  git pull
  cd ../
fi

echo "---> Cloning zsh repo:"
if ! [ -d ~/.zprezto ]; then
  if git clone git@github.com:kerinin/prezto.git ~/.zprezto; then
    echo "Cloned zprezto repo WITH commit access"
  else
    git clone git://github.com/kerinin/prezto.git ~/.zprezto
    echo "Clone zprezto WITHOUT commit access"
  fi
else
  echo "zprezto already cloned, fetching master"
  cd .zprezto
  git pull
  cd ../
fi

echo "--> Setting up git submodules:"
cd environment
git submodule init
git submodule update
cd

echo "---> Symlinking environment:"
symlink_or_backup .gitconfig environment/.gitconfig
symlink_or_backup .gemrc environment/.gemrc
symlink_or_backup .ackrc environment/.ackrc
symlink_or_backup .zlogin .zprezto/runcoms/zlogin
symlink_or_backup .zlogout .zprezto/runcoms/zlogout
symlink_or_backup .zpreztorc .zprezto/runcoms/zpreztorc
symlink_or_backup .zprofile .zprezto/runcoms/zprofile
symlink_or_backup .zshenv .zprezto/runcoms/zshenv
if command_exists vim; then symlink_or_backup .vim environment/.vim; symlink_or_backup .vimrc environment/.vimrc; fi
if command_exists rbenv; then symlink_or_backup .rbenv environment/.rbenv; fi
if command_exists gem; then symlink_or_backup .gemrc environment/.gemrc; fi
if [[ `uname` == Linux ]]; then
  if command_exists byobu; then symlink_or_backup .byobu environment/.byobu; fi
fi

echo "---> Setting up init scripts:"
if [[ `uname` == Darwin ]] && ! grep -q "^. ~/environment/.profile_osx" ~/.zshrc; then
  echo '. ~/environment/.profile_osx' >> ~/.zshrc
elif [[ `uname` == Linux ]] && ! grep -q "^. ~/environment/.profile_ubuntu" ~/.zshrc; then
  echo '. ~/environment/.profile_ubuntu' >> ~/.zshrc
else
  echo "Either I don't recognize your OS ($OSTYPE) or your init scripts are already in place"
fi

# echo "---> Setting login shell:"
# if [ "$SHELL" != "/bin/zsh" ]; then 
#   echo "Changing shell from $SHELL to /bin/zsh - you may need to enter your password"
#   sudo chsh -s /bin/zsh "$USER"
# else
#   echo "login shell already zsh"
# fi

# if [[ `uname` == Darwin ]] && ! grep -q "^. ~/environment/.profile_osx" ~/.zshrc; then
#  # See https://gist.github.com/sos4nt/3187620 for more info about this
#   echo "---> Patching terminfo:"
#   tic ~/environment/xterm-256color.terminfo
# fi


