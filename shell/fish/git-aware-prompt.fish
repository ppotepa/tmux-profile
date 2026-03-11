function __tp_git_prompt_segment
    command -sq git; or return
    git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null; or return

    set -l branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)
    if test -z "$branch"
        set branch (git describe --tags --exact-match 2>/dev/null)
    end
    if test -z "$branch"
        set branch (git rev-parse --short HEAD 2>/dev/null)
    end
    test -n "$branch"; or return

    set -l dirty (git status --porcelain --ignore-submodules=dirty 2>/dev/null)
    if test -n "$dirty"
        set -l icon "✗"
    else
        set -l icon "✔"
    end

    printf " | on %s %s" "$branch" "$icon"
end

function fish_prompt
    set -l p (prompt_pwd)
    set -l g (__tp_git_prompt_segment)
    printf "%s%s\n\$ " $p $g
end

function fish_right_prompt
    printf "with %s@%s | at %s" $USER (prompt_hostname) (date "+%H:%M:%S")
end
