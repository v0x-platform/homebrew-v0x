# homebrew-v0x

Tap de Homebrew **público** de la plataforma v0x, y repositorio de **distribución
de binarios**. Aquí NO vive código fuente: solo la fórmula Homebrew y los
*releases* con los binarios compilados del CLI y los plugins.

El código fuente vive en repos **privados** de la org `v0x-platform`
(`v0x-cli`, `v0x-forge-aws`, `v0x-sdk`, …). Sus workflows de release compilan y
**publican los binarios aquí** (repo público), de modo que la instalación no
requiere token.

## Instalación del CLI con Homebrew

```bash
# Añade el tap por su nombre canónico (SIN URL: Homebrew resuelve
# github.com/v0x-platform/homebrew-v0x). Añadirlo con la URL explícita dispara
# el aviso "untrusted tap".
brew tap v0x-platform/v0x
brew install v0x
v0x --version
```

> Si `brew` responde `Refusing to load formula ... from untrusted tap`, es porque
> el tap se añadió con la URL. Quítalo y vuelve a añadirlo por el nombre:
> `brew untap v0x-platform/v0x && brew tap v0x-platform/v0x`. Alternativa puntual:
> `brew trust v0x-platform/v0x`.


## Instalación de plugins

Los plugins (p. ej. `forge-aws`, cdylib) no se instalan por Homebrew (Homebrew es
para ejecutables del PATH). Se bajan de los releases de este repo con el CLI:

```bash
v0x plugin install forge-aws        # baja el asset del release forge-aws-* de este repo
```

## Instalación del CLI SIN Homebrew (descarga directa)

Si no usas Homebrew (o Homebrew pide actualizar las Command Line Tools), instala
el binario directamente desde el release público de ESTE repo — sin token:

```bash
# macOS Apple Silicon (ajusta la version al tag cli-v* mas reciente):
curl -fsSL "https://github.com/v0x-platform/homebrew-v0x/releases/download/cli-v0.1.8/v0x-macos-arm64" \
  -o ~/.local/bin/v0x
chmod +x ~/.local/bin/v0x
# Linux x64: usa .../cli-v0.1.8/v0x-linux-x64
v0x --version
```

> El script `install.sh` vive en el repo **privado** `v0x-cli`, así que
> `curl https://raw.githubusercontent.com/v0x-platform/v0x-cli/main/install.sh`
> devuelve **404** (raw de repo privado no sirve sin auth). Usa la descarga
> directa de arriba, o clona `v0x-cli` y corre `install.sh` localmente.

## Esquema de releases

Un release por componente, con tag prefijado:

| Componente | Tag        | Assets |
|------------|------------|--------|
| CLI        | `cli-vX.Y.Z`      | `v0x-macos-arm64`, `v0x-linux-x64` |
| forge-aws  | `forge-aws-vX.Y.Z`| `forge-aws-macos-arm64.dylib`, `forge-aws-linux-x64.so` |

Los binarios son **públicos** (descarga anónima); el código que los produce es
privado.
