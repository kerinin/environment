# Environment

## System

[iTerm2](http://www.iterm2.com/).  Set terminal to 256 colors for solarizd to work

[gcc](http://github.com/kennethreitz/osx-gcc-installer/downloads) - required fro rbenv

[Homebrew](http://mxcl.github.com/homebrew/)

Brew install:

* git
* bash-completion
* ack
* mysql
* redis
* memcached
* ruby-build
* wget
* qt

[Solarized](http://ethanschoonover.com/solarized)

[Inconsolata Font](http://leonardo-m.livejournal.com/77079.html)

XCode - available from app store.  Make sure to install Console tools from the preferences menu

[rbenv](https://github.com/sstephenson/rbenv)
 
[ruby-build](https://github.com/sstephenson/ruby-build)

[rbenv-vars](https://github.com/sstephenson/rbenv-vars)


## environment

``` sh
cd ~/
git clone git@github.com:kerinin/environment.git
cd ~/environment
git submodule init
git submodule update
cd ~/

ln -s environment/.ackrc ./
ln -s environment/.bash_profile ./
ln -s environment/.gemrc ./
ln -s environment/.rbenv ./
ln -s environment/.vim ./
ln -s environment/.vimrc ./
```


## Ruby

    rbenv install ree-1.8.7-2012.02
    rbenv install 1.9.3-p194

## Node

    brew install node
    curl http://npmjs.org/install.sh | sh
    npm install n

NPM packages (`npm install -g <package>`)

* coffee-script

## R

[Install R package](http://cran.r-project.org/bin/macosx/)

    sudo ln -s /Library/Frameworks/R.framework/Resources/R /usr/local/bin/R
    
[via](http://cran.r-project.org/bin/macosx/RMacOSX-FAQ.html).

    install.packages(c("Zelig", "sn", "np", "Rserve"))

    R CMD Rserve

