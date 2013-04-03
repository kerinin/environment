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
if [ -n "$INSTALL" ] && echo $OSTYPE | grep -Fq darwin; then
  install_stuff brew 'ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'
  install_stuff git 'brew install git'
  install_stuff mysql 'brew install mysql'
  install_stuff redis-server 'brew install redis'
  install_stuff memcached 'brew install memcached'
  install_stuff rbenv 'brew install rbenv'
  install_stuff ruby-build 'brew install ruby-build'
  install_stuff wget 'brew install wget'
  install_stuff ag 'brew install the_silver_searcher'
elif [ -n "$INSTALL" ] && echo $OSTYPE | grep -Fq linux; then
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
  echo "Either I don't recognize your OS ($OSTYPE) or you didn't set \$INSTALL=Y - not trying to install stuff"
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
if ! [ -d ~/.oh-my-zsh ]; then
  if git clone git@github.com:kerinin/oh-my-zsh.git ~/.oh-my-zsh; then
    echo "Cloned oh-my-zsh repo WITH commit access"
  else
    git clone git://github.com/kerinin/oh-my-zsh.git ~/.oh-my-zsh
    echo "Clone oh-my-zsh WITHOUT commit access"
  fi
else
  echo "oh-my-zsh already cloned, fetching master"
  cd .oh-my-zsh
  git pull
  cd ../
fi

echo "--> Setting up git submodules:"
cd environment
git submodule init
git submodule update
cd

echo "---> Symlinking environment:"
if command_exists byobu; then symlink_or_backup .byobu environment/.byobu; fi
if command_exists gem; then symlink_or_backup .gemrc environment/.gemrc; fi
if command_exists rbenv; then symlink_or_backup .rbenv environment/.rbenv; fi
if command_exists vim; then symlink_or_backup .vim environment/.vim; symlink_or_backup .vimrc environment/.vimrc; fi

echo "---> Setting up init scripts:"
if echo $OSTYPE | grep -Fq darwin && ! grep -Fxq "source ~/environment/.profile_osx" ~/.zshrc; then
  echo "source ~/environment/.profile_osx" >> ~/.zshrc
elif echo $OSTYPE | grep -Fq linux && ! grep -Fxq "source ~/environment/.profile_profile" ~/.zshrc; then
  echo "source ~/environment/.profile_ubuntu" >> ~/.zshrc
else
  echo "Either I don't recognize your OS ($OSTYPE) or your init scripts are already in place"
fi

echo "---> Setting login shell:"
if [ "$SHELL" != "/bin/zsh" ]; then 
  echo "Changing shell from $SHELL to /bin/zsh - you may need to enter your password"
  sudo chsh -s /bin/zsh "$USER"
else
  echo "login shell already zsh"
fi

source ~/.zshrc

