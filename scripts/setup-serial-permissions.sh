#!/usr/bin/env bash
set -euo pipefail

# This script configures user permissions to access USB serial devices on Linux (e.g. ESP32 on /dev/ttyUSB0).

echo "==> Configuring USB Serial permissions..."

# Temporarily grant read/write permissions to currently plugged device
if [ -e /dev/ttyUSB0 ]; then
    sudo chmod 666 /dev/ttyUSB0
    echo "✔ /dev/ttyUSB0 read/write permissions granted."
fi

if [ -e /dev/ttyACM0 ]; then
    sudo chmod 666 /dev/ttyACM0
    echo "✔ /dev/ttyACM0 read/write permissions granted."
fi

# Add user to standard serial communication groups
CURRENT_USER="${USER:-$(whoami)}"

if getent group uucp >/dev/null; then
    sudo usermod -a -G uucp "$CURRENT_USER"
    echo "✔ Added $CURRENT_USER to group 'uucp' (Arch Linux)."
fi

if getent group dialout >/dev/null; then
    sudo usermod -a -G dialout "$CURRENT_USER"
    echo "✔ Added $CURRENT_USER to group 'dialout' (Debian/Ubuntu)."
fi

echo "==> Done! If this is your first time, log out and log back in for group membership to take full effect."
