# if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash  ]; then
#   . `brew --prefix`/etc/bash_completion.d/git-completion.bash 
# fi
source ~/environment/bin/git-completion.bash
export PATH="$HOME/.rbenv/bin:$HOME/environment/bin:/usr/local/bin:$PATH"
export EDITOR="vim"
eval "$(rbenv init -)"
export JAVA_HOME=$(/usr/libexec/java_home)

# OIB shortcuts
alias oib_jenkins='ssh -l ubuntu -L8080:localhost:8080 ubuntu@ec2-50-17-93-145.compute-1.amazonaws.com'
function gcb() {
git branch | grep '^\*' | cut -c3-
}

function gcf() {
grep url .git/config | cut -d: -f2 | sed -e 's/\.git//'
}

gfb () 
{ 
  branch=`gcb`;
  git checkout master && git pull --prune;
  if [[ $1 == '--force' || -z `git branch --no-merged master | grep $branch` ]]; then
    git branch -d $branch && git push origin :$branch;
  else
    echo "Hey, man, $branch isn't merged yet!";
    git checkout $branch;
  fi
}

alias gpn='git push -u origin `gcb`'
alias gpr='open "https://github.com/`gcf`/pull/new/`gcb`"'
alias gst='git status'
alias gco='git checkout'
alias gdf='git diff'
alias gca='git commit -a'
alias gpu='git pull origin'
alias gfp='git fetch --prune'

alias bi='bundle install'
alias be='bundle exec'
alias bers='time bundle exec rspec'
alias bec='bundle exec cucumber'
alias ber='bundle exec rails'

# Pretty prompt
source ~/environment/bash_prompt.bash

# Rubinius
export RBX_ROOT=$HOME/.rbenv/versions/rbx-2.0.0-dev
export PATH=$PATH:$RBX_ROOT/gems/1.9/bin
