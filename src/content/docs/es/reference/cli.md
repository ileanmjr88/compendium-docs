---
title: Referencia de la CLI
description: Cada comando de Compendium que se incluye en v0.1, con lo que hace y qué esperar.
---

```
compendium [command]
```

`install`, `activate`, `env` y `status` leen `compendium.toml` del
directorio actual. `versions` consulta el registro directamente.
`deactivate` y `version` no leen ningún archivo de proyecto.

Cada comando escribe su salida principal en **stdout**. `activate` y
`deactivate` además dirigen sus mensajes de error y advertencia a
**stderr**, así que `source <(compendium activate)` solo evalúa el script de
shell y nunca interpreta una advertencia perdida como un comando.

## `install`

Lee `compendium.toml`, obtiene el índice del registro, descarga los
lenguajes o herramientas que falten, verifica los checksums SHA-256 y los
extrae en `~/.local/compendium/`.

```
compendium install
```

También configura el estado por proyecto bajo
`~/.local/compendium/envs/<project>/`:

- un `venv/` de Python si se declara `[languages].python`
- un workspace `go/` si se declara `[languages].go`
- un directorio `vcpkg-installed/` si se declara `[packages].vcpkg`

Idempotente. Las herramientas ya instaladas en la versión solicitada se
omiten.

## `activate`

Imprime un script de shell POSIX que antepone los directorios de
herramientas de Compendium al `PATH` y exporta las variables de entorno por
lenguaje. Ejecútelo con `source <(…)`:

```bash
source <(compendium activate)
```

Por qué `source <(…)`: el script necesita ejecutarse en su shell actual para
modificar su entorno. El script en sí es texto plano en stdout. Los mensajes
de estado van a stderr para que no contaminen la entrada de `source`.

Mientras el entorno está activo, su prompt lleva el prefijo `(compendium)`
para que sepa de un vistazo qué shells están dentro de un entorno de
Compendium. Su `PS1` original se guarda en `_COMPENDIUM_OLD_PS1` y se
restaura al desactivar. Consulte
[Solución de problemas](/es/reference/troubleshooting/#prefijo-del-prompt-de-compendium)
si mantiene un prompt personalizado y quiere desactivarlo.

## `deactivate`

Imprime un script de shell POSIX que restaura el `PATH`, las variables de
entorno y el prompt que se capturaron durante activate.

```bash
source <(compendium deactivate)
```

## `status`

Comprueba si cada lenguaje y herramienta declarados en `compendium.toml`
está presente en la versión correcta bajo `~/.local/compendium/`. Imprime
una fila por elemento. Sale con código distinto de cero si falta algo.

```
$ compendium status
  ✓ go  1.26.1
  ✓ golangci-lint  2.11.4
  ✓ environment in sync
```

Use esto después de hacer pull de cambios. Le dice si `compendium install`
necesita ejecutarse de nuevo.

## `env`

Imprime las variables de entorno resueltas para el proyecto actual como una
tabla, **sin** modificar su shell. Útil para depurar lo que activate haría.

```
$ compendium env

Environment variables:
  NAME              ACTION   VALUE
  GOROOT            set      ~/.local/compendium/languages/go/1.26.1
  GOPATH            set      ~/.local/compendium/envs/hello/go
  ...
```

## `versions`

Lista las versiones disponibles en el registro público. Sin argumento,
imprime cada lenguaje y herramienta con su última versión y el número de
versiones. Con un nombre de herramienta, imprime cada versión de esa
herramienta, la más reciente primero.

```
$ compendium versions
  Languages:
    clang   22.1.5   (24 versions)
    gcc     15.2.0   (26 versions)
    go      1.26.3   (269 versions)
    ...

  Tools:
    cmake   4.3.2    (24 versions)
    ninja   1.13.2   (18 versions)
    ...

$ compendium versions gcc
  gcc available versions:

  15.2.0-1   ← latest
  14.3.0
  13.2.0
  ...
```

Los datos vienen del mismo registro que lee el sitio de documentación.
Consulte [Herramientas disponibles](/es/reference/available-tools/) para una
vista en el navegador.

## `version`

Imprime la versión del binario de Compendium, el commit y la plataforma del
host. Útil para reportes de errores.

```
$ compendium version
compendium 0.1.0
  commit   84d2c92
  os/arch  darwin/arm64
```

Los builds desde `main` sin un tag imprimen `dev` en la línea de versión. El
commit queda como `unknown` si el binario se construyó fuera de un checkout de
git.

## `help`

`compendium help [command]` y `compendium <command> --help` ambos funcionan.
