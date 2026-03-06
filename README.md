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

## Integrated Plugins & Functionality

### tmux-resurrect & tmux-continuum
Handles environment persistence. Resurrect allows manual saving (`Prefix + Ctrl-s`) and restoring (`Prefix + Ctrl-r`) of sessions, including pane layouts and working directories. Continuum automates this by performing background saves every 15 minutes.

### tmux-yank
Integrates tmux copy-mode with the system clipboard. In copy-mode (`Prefix + v`), use `y` to yank text directly to the system's primary clipboard, bypassing the need for manual terminal selection.

### extrakto
Fuzzy search and extraction tool for on-screen text. Triggered via `Prefix + g`. It uses `fzf` to filter paths, URLs, and keywords from the current pane's scrollback buffer and inserts them directly into the command line.

### tmux-sessionist
Advanced session management. Provides shortcuts for creating sessions (`Prefix + C`), renaming (`Prefix + t`), and switching between sessions without opening the tree view.

### tmux-floax (Popup Console)
Provides a centered floating terminal popup (`Prefix + p`). Useful for running transient commands (e.g., git status, htop, or calculators) without disrupting the main pane layout.

## Tactical Utilities
- `Prefix + ` ` (backtick): Toggle status bar visibility.
- `Prefix + f`: Launch session tree/chooser.
- `Prefix + Tab`: Toggle between the two most recent windows.
