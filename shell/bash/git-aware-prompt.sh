#!/usr/bin/env bash

# Git segment: "on <branch> <status>"
__tp_git_prompt_segment() {
  command -v git >/dev/null 2>&1 || return 0
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

  local branch status icon
  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
  [ -n "$branch" ] || return 0

  if [ -n "$(git status --porcelain --ignore-submodules=dirty 2>/dev/null)" ]; then
    icon="✗"
  else
    icon="✔"
  fi

  printf ' | on %s %s' "$branch" "$icon"
}

__tp_update_ps1() {
  local reset blue cyan green
  reset='\[\e[0m\]'
  blue='\[\e[34m\]'
  cyan='\[\e[36m\]'
  green='\[\e[32m\]'

  local git_segment
  git_segment="$(__tp_git_prompt_segment)"

  # Example:
  # ~/git/tmux-profile | on main ✔ | with user@host | at 16:12:28
  # $
  PS1="${blue}\w${reset}${cyan}${git_segment}${reset}${green} | with \u@\h | at \A${reset}\n\$ "
}

if [[ "${PROMPT_COMMAND:-}" != *"__tp_update_ps1"* ]]; then
  PROMPT_COMMAND="__tp_update_ps1${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
