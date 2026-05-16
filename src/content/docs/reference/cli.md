---
title: CLI reference
description: Every Compendium command shipping in v0.1, with what it does and what to expect.
---

```
compendium [command]
```

`install`, `activate`, `env`, and `status` read `compendium.toml` from the
current directory. `versions` queries the registry directly. `deactivate`
and `version` do not read any project file.

Every command writes its main output to **stdout**. `activate` and
`deactivate` additionally route their error and warning messages to
**stderr**, so `source <(compendium activate)` only evaluates the shell
script and never interprets a stray warning as a command.

## `install`

Reads `compendium.toml`, fetches the registry index, downloads any missing
languages or tools, verifies SHA-256 checksums, and extracts them into
`~/.local/compendium/`.

```
compendium install
```

Also sets up per-project state under `~/.local/compendium/envs/<project>/`:

- a Python `venv/` if `[languages].python` is declared
- a `go/` workspace if `[languages].go` is declared
- a `vcpkg-installed/` directory if `[packages].vcpkg` is declared

Idempotent. Tools already installed at the requested version are skipped.

## `activate`

Prints a POSIX shell script that prepends Compendium's tool directories to
`PATH` and exports the per-language environment variables. Run it with
`source <(…)`:

```bash
source <(compendium activate)
```

Why `source <(…)`: the script needs to run in your current shell to modify
its environment. The script itself is plain text on stdout. Status messages
go to stderr so they do not poison the `source` input.

While the environment is active, your prompt is prefixed with `(compendium)`
so you can tell at a glance which shells are inside a Compendium env. Your
original `PS1` is saved in `_COMPENDIUM_OLD_PS1` and restored on deactivate.
See [Troubleshooting](/reference/troubleshooting/#compendium-prompt-prefix)
if you maintain a custom prompt and want to opt out.

## `deactivate`

Prints a POSIX shell script that restores the `PATH`, environment variables,
and prompt that were captured during activate.

```bash
source <(compendium deactivate)
```

## `status`

Checks whether every language and tool declared in `compendium.toml` is
present at the right version under `~/.local/compendium/`. Prints a row per
item. Exits non-zero if anything is missing.

```
$ compendium status
  ✓ go  1.26.1
  ✓ golangci-lint  2.11.4
  ✓ environment in sync
```

Use this after pulling changes. It tells you whether `compendium install`
needs to run again.

## `env`

Prints the resolved environment variables for the current project as a
table, **without** modifying your shell. Useful for debugging what activate
would do.

```
$ compendium env

Environment variables:
  NAME              ACTION   VALUE
  GOROOT            set      ~/.local/compendium/languages/go/1.26.1
  GOPATH            set      ~/.local/compendium/envs/hello/go
  ...
```

## `versions`

Lists available versions in the public registry. With no argument, prints
every language and tool with its latest version and version count. With a
tool name, prints every version of that tool, latest first.

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

The data comes from the same registry the docs site reads. See
[Available tools](/reference/available-tools/) for a browser view.

## `version`

Prints the Compendium binary version, commit, and host platform. Handy for
bug reports.

```
$ compendium version
compendium 0.1.0
  commit   84d2c92
  os/arch  darwin/arm64
```

Builds from `main` without a tag print `dev` for the version line. The commit
falls back to `unknown` if the binary was built outside a git checkout.

## `help`

`compendium help [command]` and `compendium <command> --help` both work.

