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
  version "0.1.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.6/v0x-macos-arm64"
      sha256 "e1b2f2fb9feb9a8866b3644aa2aa0b663f5711fd6b67903ffa0892bab54c4934"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.6/v0x-linux-x64"
      sha256 "bd00a3a736c7de1558b01920b189f9c0c8174618d98801c500ebe46998c643ec"
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
