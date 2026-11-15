#!/bin/sh
set -e
mkdir -p "$HOME/.local/bin"
if command -v curl >/dev/null; then
    curl -fsSL https://raw.githubusercontent.com/nomaraba/switch-gh/main/switch-gh -o "$HOME/.local/bin/switch-gh"
else
    wget -qO "$HOME/.local/bin/switch-gh" https://raw.githubusercontent.com/nomaraba/switch-gh/main/switch-gh
fi
chmod +x "$HOME/.local/bin/switch-gh"
echo "installed to $HOME/.local/bin/switch-gh"
