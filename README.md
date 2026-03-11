# Tmux WASD - Left-Hand Optimized Profile

This configuration is designed for maximum efficiency using a left-hand dominant "WASD" layout, similar to FPS gaming controls. It focuses on minimizing hand movement by binding core navigation and utility functions to the left side of the keyboard.

## Installation

1. Clone or copy `.tmux-wsad.conf` to `~/.tmux.conf`.
2. Install [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) if not already present.
3. Launch tmux and run `Prefix + I` to fetch and install plugins.
4. Reload config: `Prefix + r`.

## Core Navigation (WASD)

- **Prefix:** `Ctrl-a`.
- **Movement:** `Prefix + W/A/S/D` or `Alt + W/A/S/D` for instant pane switching.
- **Window Management:** `Alt + 1..6` for direct window selection.
- **Splits:** `q` for vertical split, `e` for horizontal split.
- **Resizing:** `Prefix + Shift + W/A/S/D` for 5-unit increments.
- **Zoom/Sniper:** `Prefix + Z` toggles pane zoom and status bar visibility simultaneously.

## Plugins (Current Config)

Configured in `.tmux-wsad.conf`:

- `tmux-plugins/tpm` - plugin manager (required, loaded at the end of config).
- `tmux-plugins/tmux-resurrect` - manual save/restore of sessions.
- `tmux-plugins/tmux-continuum` - automatic periodic save/restore on top of resurrect.
- `tmux-plugins/tmux-yank` - copy-mode integration with system clipboard.
- `laktak/extrakto` - fuzzy extraction/search from pane history.
- `tmux-plugins/tmux-sessionist` - additional session management shortcuts.
- `omerxx/tmux-floax` - popup terminal; this config sets `@floax-bind` to `p` (`Prefix + p` / `Alt + p`).

## Plugin Notes

### tmux-resurrect & tmux-continuum
Handles environment persistence. Resurrect allows manual saving (`Prefix + Ctrl-s`) and restoring (`Prefix + Ctrl-r`) of sessions, including pane layouts and working directories. Continuum automates this by performing background saves.

### tmux-yank
Integrates tmux copy-mode with the system clipboard. In copy-mode (`Prefix + v`), use `y` to yank text directly to the system clipboard.

### extrakto
Fuzzy search and extraction tool for on-screen text. Triggered via `Prefix + g`.

### tmux-floax (Popup Console)
Provides a centered floating terminal popup (`Prefix + p` or `Alt + p`).

## Tactical Utilities
- `Prefix + \`` (backtick): Toggle status bar visibility.
- `Prefix + f`: Launch session tree/chooser.
- `Prefix + Tab`: Toggle between the two most recent windows.

## Shell Prompt (Bash + Fish)

If you also want a git-aware shell prompt (branch + dirty/clean state + user/host + time), this repo includes ready-to-source configs:

- Bash: `shell/bash/git-aware-prompt.sh`
- Fish: `shell/fish/git-aware-prompt.fish`

Quick install:

```bash
# Bash
echo 'source /home/ppotepa/git/tmux-profile/shell/bash/git-aware-prompt.sh' >> ~/.bashrc

# Fish
mkdir -p ~/.config/fish/conf.d
cp /home/ppotepa/git/tmux-profile/shell/fish/git-aware-prompt.fish ~/.config/fish/conf.d/git-aware-prompt.fish
```

Reload shell (`exec bash` / restart fish) and the prompt will show git context when inside a repo.

### Key Bindings

This section details all the key bindings available in this tmux profile, categorized for easy reference. The default prefix is `C-a`.

| Category | Key Binding | Description |
|---|---|---|
| **Prefix** | `C-a` | Send prefix |
| **Core Settings** | `Mouse on` | Enable mouse support |
| | `history-limit 50000` | Set history limit |
| | `mode-keys vi` | Use vi keys in copy mode |
| **One-Hand WASD Pane Layout** | `C-a q` | Split pane vertically |
| | `C-a e` | Split pane horizontally |
| | `C-a a` | Select pane left |
| | `C-a s` | Select pane down |
| | `C-a w` | Select pane up |
| | `C-a d` | Select pane right |
| | `C-a A` | Resize pane left (repeatable) |
| | `C-a S` | Resize pane down (repeatable) |
| | `C-a W` | Resize pane up (repeatable) |
| | `C-a D` | Resize pane right (repeatable) |
| | `C-a z` | Toggle zoom pane |
| | `C-a v` | Enter copy mode |
| | `C-a f` | Display pane numbers |
| | `C-a Space` | Next layout |
| **Left-Hand No-Prefix Extensions (Alt-bindings)** | `M-a` | Select pane left (no prefix) |
| | `M-s` | Select pane down (no prefix) |
| | `M-w` | Select pane up (no prefix) |
| | `M-d` | Select pane right (no prefix) |
| | `M-1` | Select window 1 (no prefix) |
| | `M-2` | Select window 2 (no prefix) |
| | `M-3` | Select window 3 (no prefix) |
| | `M-4` | Select window 4 (no prefix) |
| | `M-5` | Select window 5 (no prefix) |
| | `M-6` | Select window 6 (no prefix) |
| **Pane / Window Helpers** | `C-a Q` | Swap pane up |
| | `C-a E` | Swap pane down |
| | `C-a t` | Rename window |
| | `C-a \`` | Toggle status line |
| | `C-a V` | Paste buffer |
| | `C-a F` | Choose tree (sessions, windows, panes) |
| | `C-a Z` | Toggle zoom pane and status line |
| **Windows** | `C-a c` | New window |
| | `C-a g` | Choose window |
| | `C-a Tab` | Last window |
| | `C-a 1` | Select window 1 |
| | `C-a 2` | Select window 2 |
| | `C-a 3` | Select window 3 |
| | `C-a 4` | Select window 4 |
| | `C-a 5` | Select window 5 |
| | `C-a 6` | Select window 6 |
| | `C-a !` | Move window to slot 1 |
| | `C-a @` | Move window to slot 2 |
| | `C-a #` | Move window to slot 3 |
| | `C-a $` | Move window to slot 4 |
| | `C-a %` | Move window to slot 5 |
| | `C-a ^` | Move window to slot 6 |
| **Sessions** | `C-a S` | New named session |
| | `C-a C-s` | Session picker / tree |
| | `C-a (` | Previous session |
| | `C-a )` | Next session |
| | `C-a l` | Jump back to last session |
| | `C-a C-x` | Kill current session (confirm) |
| **Function Keys** | `C-a F5` | Choose tree (sessions, windows, panes) |
| | `C-a F6` | Detach client |
| **Safety / Utilities** | `C-a r` | Reload config |
| | `C-a x` | Kill pane (confirm) |
| | `C-a X` | Kill window (confirm) |
| | `C-a /` | Find window |
| **Mouse Session Switching (No-Prefix)** | `WheelUpStatus` | Previous session |
| | `WheelDownStatus` | Next session |
| | `C-S-WheelUpPane` | Previous session (optional) |
| | `C-S-WheelDownPane` | Next session (optional)
