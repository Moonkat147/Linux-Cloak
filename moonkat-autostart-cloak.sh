#!/usr/bin/env bash
# Moonk@t Autostart Cloak v1.47

set -euo pipefail

AUTOSTART_SYS="/etc/xdg/autostart"
AUTOSTART_USER="$HOME/.config/autostart"

mkdir -p "$AUTOSTART_USER"

# List of system autostart files we want to shadow + hide
TO_HIDE=(
  geoclue-demo-agent.desktop          # location tracking demo agent
  gnome-keyring-secrets.desktop      # GNOME keyring (secrets)
  gnome-keyring-ssh.desktop          # GNOME keyring (SSH)
  gnome-keyring-pkcs11.desktop       # GNOME keyring (PKCS#11)
  org.kde.discover.notifier.desktop  # KDE update notifier
  spice-vdagent.desktop              # VM guest agent (if not in VM)
  nvidia-settings-autostart.desktop  # auto-launch Nvidia settings
  xdg-user-dirs.desktop              # auto-manage user dirs
  xdg-user-dirs-kde.desktop          # KDE helper for user dirs
)

echo "=== Moonk@t Autostart Cloak ==="
echo "System autostart dir: $AUTOSTART_SYS"
echo "User autostart dir:   $AUTOSTART_USER"
echo

for f in "${TO_HIDE[@]}"; do
  SRC="$AUTOSTART_SYS/$f"
  DEST="$AUTOSTART_USER/$f"

  if [[ -f "$SRC" ]]; then
    cp "$SRC" "$DEST"

    # Only append Hidden=true if it's not already there
    if ! grep -q '^Hidden=true' "$DEST"; then
      echo 'Hidden=true' >> "$DEST"
    fi

    echo "🔥 Cloaked: $f"
  else
    echo "⚠️  Skipped (not found): $f"
  fi
done

echo
echo "Done. Log out and back in (or reboot) to feel the silence. 😼"
