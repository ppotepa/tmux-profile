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
