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
brew tap v0x-platform/v0x https://github.com/v0x-platform/homebrew-v0x
brew install v0x
v0x --version
```

## Instalación de plugins

Los plugins (p. ej. `forge-aws`, cdylib) no se instalan por Homebrew (Homebrew es
para ejecutables del PATH). Se bajan de los releases de este repo con el CLI o el
`install.sh`:

```bash
v0x plugin install forge-aws        # baja el asset del release forge-aws-* de este repo
```

## Esquema de releases

Un release por componente, con tag prefijado:

| Componente | Tag        | Assets |
|------------|------------|--------|
| CLI        | `cli-vX.Y.Z`      | `v0x-macos-arm64`, `v0x-linux-x64` |
| forge-aws  | `forge-aws-vX.Y.Z`| `forge-aws-macos-arm64.dylib`, `forge-aws-linux-x64.so` |

Los binarios son **públicos** (descarga anónima); el código que los produce es
privado.
