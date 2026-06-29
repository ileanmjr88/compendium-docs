---
title: Primeros pasos
description: Configure su primer proyecto con Compendium en menos de cinco minutos.
---

Esta guía lo lleva de principio a fin por su primer proyecto con Compendium:
definir un toolchain en `compendium.toml`, instalarlo, activarlo y ver
exactamente qué quedó dónde.

## 1. Cree un `compendium.toml`

En un directorio vacío, cree un archivo llamado `compendium.toml`:

```toml
[compendium]
name = "hello"
version = "0.1.0"
min_compendium = "0.1.0"

[registry]
source = "public"

[languages]
go = "1.26.1"

[tools]
golangci-lint = "2.11.4"

[packages]
go = "go.mod"
```

Eso es todo. Compendium lee este archivo como la única fuente de verdad para el
entorno del proyecto. Cualquiera que clone el repositorio y ejecute
`compendium install` obtiene el mismo Go, el mismo linter, en la misma versión.
Eso lo incluye a usted en el futuro, en una laptop nueva.

## 2. Instale

```bash
compendium install
```

Compendium obtiene el índice del registro público, resuelve contra él las
versiones que declaró, descarga los tarballs, verifica sus checksums SHA-256 y
los extrae en `~/.local/compendium/`.

Debería ver algo como:

```
→ fetching index  public
✓ index ok
↓ go 1.26.1
✓ checksum ok
↓ golangci-lint 2.11.4
✓ checksum ok
✓ environment ready
```

## 3. Active

Los comandos activate y deactivate imprimen scripts de shell POSIX en stdout.
Ejecútelos con `source <(…)` para que el script se ejecute en su shell actual:

```bash
source <(compendium activate)
```

Ahora compruebe que las herramientas correctas estén en su `PATH`:

```bash
which go            # ~/.local/compendium/languages/go/1.26.1/bin/go
which golangci-lint # ~/.local/compendium/tools/golangci-lint/2.11.4/bin/golangci-lint
go version          # go version go1.26.1 ...
```

## 4. Compruebe el estado

```bash
compendium status
```

Confirma que el entorno instalado coincide con lo que declara `compendium.toml`.
Si una versión del toml cambia (porque la editó, o porque hizo pull de cambios
desde algún lado), este es el comando que le avisa que sus herramientas
instaladas están desincronizadas.

## 5. Desactive

Cuando termine, o al cambiar a otro proyecto, restaure su `PATH` original:

```bash
source <(compendium deactivate)
```

Las herramientas del sistema vuelven exactamente a como estaban.

## Dónde vive cada cosa

Compendium organiza todo bajo `~/.local/compendium/`:

```
~/.local/compendium/
├── languages/       # todo lo de [languages]
│   └── go/1.26.1/
├── tools/           # todo lo de [tools]
│   └── golangci-lint/2.11.4/
└── envs/            # estado por proyecto (venvs, vcpkg-installed, etc.)
    └── hello/
```

Los binarios se comparten entre todos los proyectos que declaran la misma
versión. El estado específico de cada proyecto (venvs de Python, bibliotecas
vcpkg-installed, workspaces de Go) vive en `envs/<project>/`.

:::note
**Sin sudo. Sin root. Sin directorios del sistema.** Compendium solo escribe
bajo `~/.local/compendium/`.
:::

## Qué sigue

- ¿Está construyendo un proyecto en C o C++? Consulte la [guía de proyectos en C/C++](/es/guides/cpp-project/). Hay algunas consideraciones específicas de cada plataforma que conviene conocer.
- ¿Quiere ver todas las herramientas y versiones que ofrece el registro actualmente? Consulte [Herramientas disponibles](/es/reference/available-tools/).
- ¿Quiere la referencia completa de la CLI? Consulte la [referencia de la CLI](/es/reference/cli/).
