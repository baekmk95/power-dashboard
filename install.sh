#!/usr/bin/env bash
set -euo pipefail

REPO="baekmk95/power-dashboard"
BRANCH="master"

INSTALL_DIR="${HOME}/.local/bin"
INSTALL_PATH="${INSTALL_DIR}/power"
URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/power"

echo
echo "Installing POWER Dashboard..."

command -v python3 >/dev/null 2>&1 || {
    echo "Error: python3 is required."
    exit 1
}

command -v curl >/dev/null 2>&1 || {
    echo "Error: curl is required."
    exit 1
}

mkdir -p "$INSTALL_DIR"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

curl -fsSL "$URL" -o "$tmp"

head -n 1 "$tmp" | grep -q "python3" || {
    echo "Error: downloaded file is invalid."
    exit 1
}

mv "$tmp" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo
echo "Installed:"
echo "  $INSTALL_PATH"
echo

case ":$PATH:" in
    *":$INSTALL_DIR:"*)
        ;;
    *)
        echo "NOTE: ~/.local/bin is not currently in PATH."
        echo
        echo 'Add this to ~/.bashrc:'
        echo '  export PATH="$HOME/.local/bin:$PATH"'
        echo
        ;;
esac

echo "Run:"
echo "  power"
echo
