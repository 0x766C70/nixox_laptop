#!/usr/bin/env bash
# Tailscale exit-node selector TUI
# Uses fzf to present a menu of exit-node options and applies the chosen one.

OPTIONS=(
  "1) Direct (no exit node)"
  "2) gateway-fdn"
  "3) gateway-azul"
  "4) gateway-766c70"
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
  "2) gateway-fdn")
    sudo tailscale set --exit-node=gateway-fdn
    echo "Exit node set to: fdn"
    ;;
  "3) gateway-azul")
    sudo tailscale set --exit-node=gateway-azul
    echo "Exit node set to: azul"
    ;;
  "4) gateway-766c70")
    sudo tailscale set --exit-node=gateway-766c70
    echo "Exit node set to: 766c70"
    ;;
  *)
    echo "No selection made. Exiting."
    exit 1
    ;;
esac
