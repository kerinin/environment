# if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash  ]; then
#   . `brew --prefix`/etc/bash_completion.d/git-completion.bash 
# fi
source ~/git-completion.bash
export PATH="$HOME/.rbenv/bin:$HOME/environment/bin:/usr/local/bin/:$PATH"
export EDITOR="vim"
eval "$(rbenv init -)"

# OIB shortcuts
alias oib_jenkins='ssh -l ubuntu -L8080:localhost:8080 ubuntu@ec2-50-17-93-145.compute-1.amazonaws.com'
function gcb() {
git branch | grep '^\*' | cut -c3-
}

function gco() {
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
alias gpr='open "https://github.com/`gco`/pull/new/`gcb`"'
alias be='bundle exec'
alias bers='time bundle exec rspec'
