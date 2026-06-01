#!/usr/bin/env bash
set -u

PKG_FILE="/home/tgsung/Desktop/ubuntu26_packages_user_only.txt"
OK_LOG="/home/tgsung/Desktop/ubuntu26_install_ok.txt"
FAIL_LOG="/home/tgsung/Desktop/ubuntu26_install_fail.txt"

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root: sudo bash $0"
  exit 1
fi

if [[ ! -f "$PKG_FILE" ]]; then
  echo "Package list not found: $PKG_FILE"
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

: > "$OK_LOG"
: > "$FAIL_LOG"

apt-get update

while IFS= read -r pkg; do
  [[ -z "$pkg" ]] && continue
  [[ "$pkg" =~ ^# ]] && continue

  echo "==> Installing: $pkg"
  if apt-get install -y "$pkg"; then
    echo "$pkg" >> "$OK_LOG"
  else
    echo "$pkg" >> "$FAIL_LOG"
  fi
done < "$PKG_FILE"

echo
echo "Install finished."
echo "Success: $(wc -l < \"$OK_LOG\")"
echo "Failed : $(wc -l < \"$FAIL_LOG\")"
echo "OK log : $OK_LOG"
echo "Fail log: $FAIL_LOG"
