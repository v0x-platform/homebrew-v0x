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
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.4/v0x-macos-arm64"
      sha256 "a1ea68d86bbfe4fae69f69c66e4666ab6a4445ce085272783e24752ae63c19f0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.4/v0x-linux-x64"
      sha256 "ca4f64dac1eb417578f1c564419fc31cc24d69881ee37bc6c34bedb005efc570"
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
