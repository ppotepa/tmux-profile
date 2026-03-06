# Tmux WASD Profile

An "Ultimate WASD One-Hand Profile" for tmux, optimized for left-hand efficiency and a "gamer" aesthetic.

## Key Features

- **Prefix:** `Ctrl-a` (rebound from `Ctrl-b`).
- **WASD Navigation:** Move between panes using `Prefix + W/A/S/D` or `Alt + W/A/S/D`.
- **Sprint Resize:** Resize panes with `Prefix + Shift + W/A/S/D`.
- **RTS-style Control Groups:** Quick window switching using `Alt + 1-6` or `Prefix + 1-6`.
- **Focus Mode:** `Prefix + Z` to zoom a pane and hide the status bar (Sniper Mode).
- **Session Persistence:** Integrated with `tmux-resurrect` and `tmux-continuum`.

## Installation

1. Clone this config:
   ```bash
   cp .tmux-wsad.conf ~/.tmux.conf
   ```
2. Install [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```
3. Load the config in tmux and press `Prefix + I` to install plugins.

## Layout Shortcuts

- `q` / `e`: Split window (Vertical/Horizontal)
- `t`: Rename window (Type/Talk)
- `f`: Choose session (Full Map)
- `v`: Copy mode
- `` ` ``: Toggle status bar (HUD)
