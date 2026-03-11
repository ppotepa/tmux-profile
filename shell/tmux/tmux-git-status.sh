#!/usr/bin/env bash

set -u

path="${1:-}"
[ -n "$path" ] || exit 0
[ -d "$path" ] || exit 0

cd "$path" || exit 0

command -v git >/dev/null 2>&1 || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
[ -n "$branch" ] || exit 0

status="$(git status --porcelain --branch --ignore-submodules=dirty 2>/dev/null)" || exit 0
git_dir="$(git rev-parse --git-dir 2>/dev/null)" || exit 0

ahead=0
behind=0
staged=0
modified=0
deleted=0
untracked=0
conflicts=0
mode=""

while IFS= read -r line; do
  [ -n "$line" ] || continue

  if [[ "$line" == '## '* ]]; then
    if [[ "$line" =~ ahead[[:space:]]+([0-9]+) ]]; then
      ahead="${BASH_REMATCH[1]}"
    fi
    if [[ "$line" =~ behind[[:space:]]+([0-9]+) ]]; then
      behind="${BASH_REMATCH[1]}"
    fi
    continue
  fi

  if [[ "$line" == '?? '* ]]; then
    untracked=$((untracked + 1))
    continue
  fi

  x="${line:0:1}"
  y="${line:1:1}"

  case "$x$y" in
    DD|AU|UD|UA|DU|AA|UU)
      conflicts=$((conflicts + 1))
      continue
      ;;
  esac

  case "$x" in
    A|M|R|C|T)
      staged=$((staged + 1))
      ;;
    D)
      deleted=$((deleted + 1))
      ;;
    U)
      conflicts=$((conflicts + 1))
      ;;
  esac

  case "$y" in
    M|T)
      modified=$((modified + 1))
      ;;
    D)
      deleted=$((deleted + 1))
      ;;
    U)
      conflicts=$((conflicts + 1))
      ;;
  esac
done <<< "$status"

if [ -f "$git_dir/rebase-merge/head-name" ] || [ -d "$git_dir/rebase-apply" ]; then
  mode="REB"
elif [ -f "$git_dir/MERGE_HEAD" ]; then
  mode="MRG"
elif [ -f "$git_dir/CHERRY_PICK_HEAD" ]; then
  mode="CHY"
elif [ -f "$git_dir/REVERT_HEAD" ]; then
  mode="REV"
elif [ -f "$git_dir/BISECT_LOG" ]; then
  mode="BIS"
fi

delta_line="$(git diff --numstat 2>/dev/null; git diff --cached --numstat 2>/dev/null)"
read -r delta_add delta_del <<< "$(awk '
  BEGIN {a=0; d=0}
  NF>=3 {
    if ($1 ~ /^[0-9]+$/) a += $1;
    if ($2 ~ /^[0-9]+$/) d += $2;
  }
  END {printf "%d %d", a, d}
' <<< "$delta_line")"

last_file_raw="$(git -c core.quotepath=false status --porcelain 2>/dev/null | tail -n1 | sed -E 's/^.. //')"
if [[ "$last_file_raw" == *" -> "* ]]; then
  last_file_raw="${last_file_raw##* -> }"
fi
if [ -n "$last_file_raw" ]; then
  last_file_raw="${last_file_raw%/}"
  last_file="${last_file_raw##*/}"
  [ ${#last_file} -gt 24 ] && last_file="...${last_file: -21}"
else
  last_file=""
fi

summary=()
[ -n "$mode" ] && summary+=("#[fg=colour196,bold]${mode}#[default]")
[ "$ahead" -gt 0 ] && summary+=("#[fg=colour48]U${ahead}#[default]")
[ "$behind" -gt 0 ] && summary+=("#[fg=colour214]D${behind}#[default]")
[ "$staged" -gt 0 ] && summary+=("#[fg=colour82]+${staged}#[default]")
[ "$modified" -gt 0 ] && summary+=("#[fg=colour220]~${modified}#[default]")
[ "$deleted" -gt 0 ] && summary+=("#[fg=colour203]-${deleted}#[default]")
[ "$untracked" -gt 0 ] && summary+=("#[fg=colour213]?${untracked}#[default]")
[ "$conflicts" -gt 0 ] && summary+=("#[fg=colour196,bold]!${conflicts}#[default]")
[ "$delta_add" -gt 0 ] || [ "$delta_del" -gt 0 ] && summary+=("#[fg=colour39]d+${delta_add}/-${delta_del}#[default]")
[ -n "$last_file" ] && summary+=("#[fg=colour250]f:${last_file}#[default]")

if [ "${#summary[@]}" -eq 0 ]; then
  summary=("#[fg=colour82]OK#[default]")
fi

tail="${summary[0]}"
for item in "${summary[@]:1}"; do
  tail="${tail} #[fg=colour240]| #[default]${item}"
done

printf "#[fg=colour81]%s#[default] #[fg=colour240]| #[default]%s" "$branch" "$tail"
