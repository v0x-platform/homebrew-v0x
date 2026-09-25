#!/usr/bin/env bash
# Actualiza Formula/v0x.rb tras un release del CLI: fija version, urls y sha256
# de los assets del tag cli-vX.Y.Z de este repo (homebrew-v0x).
#
# Uso (lo invoca el workflow de release de v0x-cli, o a mano):
#   CLI_VERSION=0.1.2 bash scripts/update-formula.sh    # (o VERSION=0.1.2)
#
# Requiere que los assets v0x-macos-arm64 y v0x-linux-x64 ya estén publicados
# en el release cli-v$VERSION de v0x-platform/homebrew-v0x.
set -euo pipefail

# Acepta CLI_VERSION (coherente con install.sh) o VERSION.
VERSION="${CLI_VERSION:-${VERSION:-}}"
: "${VERSION:?export CLI_VERSION=X.Y.Z (o VERSION=X.Y.Z)}"
ORG="v0x-platform"
REPO="homebrew-v0x"
TAG="cli-v${VERSION}"
FORMULA="$(dirname "$0")/../Formula/v0x.rb"
BASE="https://github.com/$ORG/$REPO/releases/download/$TAG"

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

sha_of() {
  local asset="$1"
  curl -fsSL "$BASE/$asset" -o "$tmp/$asset"
  shasum -a 256 "$tmp/$asset" | awk '{print $1}'
}

SHA_MAC="$(sha_of v0x-macos-arm64)"
SHA_LINUX="$(sha_of v0x-linux-x64)"

# Reescribe version, urls y sha256 en la fórmula (macOS sed).
sed -i '' \
  -e "s|^  version \".*\"|  version \"${VERSION}\"|" \
  -e "s|${REPO}/releases/download/cli-v[0-9.]*/v0x-macos-arm64|${REPO}/releases/download/${TAG}/v0x-macos-arm64|" \
  -e "s|${REPO}/releases/download/cli-v[0-9.]*/v0x-linux-x64|${REPO}/releases/download/${TAG}/v0x-linux-x64|" \
  "$FORMULA"

# sha256: reemplaza los placeholders o los valores previos (dos líneas sha256).
awk -v mac="$SHA_MAC" -v lin="$SHA_LINUX" '
  /v0x-macos-arm64/ {print; getline; sub(/sha256 ".*"/, "sha256 \"" mac "\""); print; next}
  /v0x-linux-x64/   {print; getline; sub(/sha256 ".*"/, "sha256 \"" lin "\""); print; next}
  {print}
' "$FORMULA" > "$FORMULA.tmp" && mv "$FORMULA.tmp" "$FORMULA"

echo "Formula actualizada a $VERSION (mac=$SHA_MAC linux=$SHA_LINUX)"
