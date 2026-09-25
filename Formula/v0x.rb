# Fórmula Homebrew del CLI v0x.
#
# Descarga el binario publicado en los releases PÚBLICOS de este mismo repo
# (v0x-platform/homebrew-v0x), tag `cli-vX.Y.Z`. El código fuente vive en el
# repo privado v0x-platform/v0x-cli; aquí solo se distribuye el binario.
#
# Instalación:
#   brew tap v0x-platform/v0x https://github.com/v0x-platform/homebrew-v0x
#   brew install v0x
#
# Al publicar una versión nueva, el workflow de release de v0x-cli actualiza
# `version`, las dos `url` y sus `sha256` (ver scripts/update-formula.sh).
class V0x < Formula
  desc "CLI de la plataforma v0x (gestor de plugins y orquestador de forja)"
  homepage "https://github.com/v0x-platform/v0x-cli"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.2/v0x-macos-arm64"
      sha256 "REEMPLAZAR_SHA256_MACOS_ARM64"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.2/v0x-linux-x64"
      sha256 "REEMPLAZAR_SHA256_LINUX_X64"
    end
  end

  def install
    # El asset se descarga con el nombre del final de la URL; lo instalamos como `v0x`.
    bin.install Dir["*"].first => "v0x"
  end

  test do
    assert_match "v0x", shell_output("#{bin}/v0x --version")
  end
end
