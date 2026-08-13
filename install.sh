#!/usr/bin/env bash
#
# 3x-ui Subscription Template installer
#
#   bash <(curl -Ls https://raw.githubusercontent.com/mahdizo3181/3x-ui-Subscription-Template/main/install.sh)
#
# Optional:
#   INSTALL_DIR=/root/my-template bash <(curl -Ls .../install.sh)

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/mahdizo3181/3x-ui-Subscription-Template/main"
INSTALL_DIR="${INSTALL_DIR:-/opt/3x-ui-sub-template}"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

info()  { echo -e "${CYAN}[*]${NC} $1"; }
ok()    { echo -e "${GREEN}[✓]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
fail()  { echo -e "${RED}[x]${NC} $1"; exit 1; }

[[ "$(id -u)" -eq 0 ]] || fail "Please run as root (or with sudo)."

if command -v curl >/dev/null 2>&1; then
    DL() { curl -fsSL "$1" -o "$2"; }
elif command -v wget >/dev/null 2>&1; then
    DL() { wget -qO "$2" "$1"; }
else
    fail "Neither curl nor wget is installed. Install one and try again."
fi

echo
echo -e "${BOLD}  3x-ui Subscription Template${NC}"
echo -e "  https://github.com/mahdizo3181/3x-ui-Subscription-Template"
echo

info "Installing to ${INSTALL_DIR}"
mkdir -p "$INSTALL_DIR"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

info "Downloading sub.html ..."
DL "${REPO_RAW}/sub.html" "${TMP_DIR}/sub.html" || fail "Download of sub.html failed."
[[ -s "${TMP_DIR}/sub.html" ]] || fail "Downloaded sub.html is empty."

if [[ -f "${INSTALL_DIR}/sub.html" ]]; then
    cp "${INSTALL_DIR}/sub.html" "${INSTALL_DIR}/sub.html.bak"
    warn "Existing sub.html backed up to sub.html.bak"
fi
mv "${TMP_DIR}/sub.html" "${INSTALL_DIR}/sub.html"
ok "sub.html installed."

# config.json is user data — never overwrite an existing one.
if [[ -f "${INSTALL_DIR}/config.json" ]]; then
    ok "Existing config.json kept."
else
    info "Downloading config.json ..."
    DL "${REPO_RAW}/config.json" "${INSTALL_DIR}/config.json" || fail "Download of config.json failed."
    ok "config.json installed."
fi

# Ask for the support ID interactively (works with `bash <(curl ...)` and with a tty).
SUPPORT_ID=""
if [[ -t 0 ]]; then
    read -r -p "$(echo -e "${CYAN}[?]${NC} Telegram support ID (e.g. @MySupport, press Enter to skip): ")" SUPPORT_ID || true
elif [[ -r /dev/tty ]]; then
    read -r -p "$(echo -e "${CYAN}[?]${NC} Telegram support ID (e.g. @MySupport, press Enter to skip): ")" SUPPORT_ID 2>/dev/null </dev/tty || true
fi

if [[ -n "$SUPPORT_ID" ]]; then
    [[ "$SUPPORT_ID" == @* ]] || SUPPORT_ID="@${SUPPORT_ID}"
    printf '{\n    "support_id": "%s"\n}\n' "$SUPPORT_ID" > "${INSTALL_DIR}/config.json"
    ok "Support ID set to ${SUPPORT_ID}"
else
    warn "Support ID skipped — edit ${INSTALL_DIR}/config.json later if you want one."
fi

chmod 755 "$INSTALL_DIR"
chmod 644 "${INSTALL_DIR}/sub.html" "${INSTALL_DIR}/config.json"

echo
echo -e "${GREEN}${BOLD}  Installation complete.${NC}"
echo
echo -e "  Put this path in your 3x-ui panel:"
echo
echo -e "      ${BOLD}${YELLOW}${INSTALL_DIR}${NC}"
echo
echo -e "  Panel ➜ ${BOLD}Panel Settings${NC} ➜ ${BOLD}Subscription${NC} ➜ ${BOLD}Profile${NC} ➜ ${BOLD}Sub Theme Directory${NC}"
echo -e "  Save the settings, then restart the panel:  ${BOLD}x-ui restart${NC}"
echo
