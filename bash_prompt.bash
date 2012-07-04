#! /bin/bash

RED="\[\e[0;31m\]"
YELLOW="\[\e[0;33m\]"
GREEN="\[\e[0;32m\]"
BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
SUBTLE="\[\e[1;32m\]"
NORMAL="\[\e[0m\]"

function parse_git_branch {
  git_status="$(git status 2> /dev/null)"
  pattern="^# On branch ([^${IFS}]*)"
  status=${git_status}

  if [[ $status =~ ${pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    commit_state_color=$(parse_commit_status "$status")
    push_status=$(parse_push_status "$status")

    result="${commit_state_color}${branch}${NORMAL} ${push_status}${commit_state_color}${NORMAL}"

    echo "${BLUE}❦ ${result}"
  fi
}

function parse_commit_status () {
  if [[ "$1" =~ "working directory clean" ]]; then
    echo "${GREEN}"
  elif [[ "$1" =~ "Changes to be committed:" ]]; then
    echo "${YELLOW}"
  elif [[ "$1" =~ "Changes not staged for commit:" ]]; then
    echo "${RED}"
  elif [[ "$1" =~ "Untracked files:" ]]; then
    echo "${BLUE}"
  else
    echo "${NORMAL}"
  fi
}

function parse_push_status () {
  if [[ "$1" =~ "Your branch is ahead" ]]; then
    echo "${GREEN}⟳  ${NORMAL}"
  elif [[ "$1" =~ "Your branch is behind" ]]; then
    echo "${YELLOW}⟲  ${NORMAL}"
  elif [[ "$1" =~ "have diverged" ]]; then
    echo "${RED}⟿  ${NORMAL}"
  fi
}

function ps1_function {
  export PS1="$SUBTLE\W ${NORMAL}$(parse_git_branch)${BLUE}❧ ${NORMAL}"
}

export PROMPT_COMMAND='ps1_function'
