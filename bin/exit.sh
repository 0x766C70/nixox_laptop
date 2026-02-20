#!/usr/bin/env bash
# Tailscale exit-node selector TUI
# Uses fzf to present a menu of exit-node options and applies the chosen one.

OPTIONS=(
  "1) Direct (no exit node)"
  "2) vlaptop"
  "3) casaazul"
)

CHOICE=$(printf '%s\n' "${OPTIONS[@]}" | fzf \
  --prompt="Tailscale exit node > " \
  --height=7 \
  --border \
  --no-sort)

case "$CHOICE" in
  "1) Direct (no exit node)")
    sudo tailscale set --exit-node=
    echo "Exit node cleared — going direct."
    ;;
  "2) vlaptop")
    sudo tailscale set --exit-node=vlaptop
    echo "Exit node set to: vlaptop"
    ;;
  "3) casaazul")
    sudo tailscale set --exit-node=casaazul
    echo "Exit node set to: casaazul"
    ;;
  *)
    echo "No selection made. Exiting."
    exit 1
    ;;
esac
