---
title: First steps
description: Set up your first project with Compendium in under five minutes.
---

This walks you through your first Compendium project end-to-end: define a
toolchain in `compendium.toml`, install it, activate it, and see exactly what
landed where.

## 1. Create a `compendium.toml`

In an empty directory, create a file called `compendium.toml`:

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

That's it. Compendium reads this file as the single source of truth for the
project's environment. Anyone who clones the repo and runs `compendium install`
gets the same Go, the same linter, at the same version. That includes future-you
on a new laptop.

## 2. Install

```bash
compendium install
```

Compendium fetches the public registry index, resolves your declared versions
against it, downloads the tarballs, verifies their SHA-256 checksums, and
extracts them into `~/.local/compendium/`.

You should see something like:

```
→ fetching index  public
✓ index ok
↓ go 1.26.1
✓ checksum ok
↓ golangci-lint 2.11.4
✓ checksum ok
✓ environment ready
```

## 3. Activate

The activate and deactivate commands print POSIX shell scripts to stdout. Run
them via `source <(…)` so the script executes in your current shell:

```bash
source <(compendium activate)
```

Now check that the right tools are on your `PATH`:

```bash
which go            # ~/.local/compendium/languages/go/1.26.1/bin/go
which golangci-lint # ~/.local/compendium/tools/golangci-lint/2.11.4/bin/golangci-lint
go version          # go version go1.26.1 ...
```

## 4. Check status

```bash
compendium status
```

Confirms your installed environment matches what `compendium.toml` declares.
If a version in the toml changes (because you edited it, or because you pulled
changes from somewhere), this is the command that tells you your installed
tools are out of sync.

## 5. Deactivate

When you're done, or switching to another project, restore your original
`PATH`:

```bash
source <(compendium deactivate)
```

System tools come back exactly as they were.

## Where things live

Compendium organizes everything under `~/.local/compendium/`:

```
~/.local/compendium/
├── languages/       # everything from [languages]
│   └── go/1.26.1/
├── tools/           # everything from [tools]
│   └── golangci-lint/2.11.4/
└── envs/            # per-project state (venvs, vcpkg-installed, etc.)
    └── hello/
```

Binaries are shared across every project that declares the same version.
Project-specific state (Python venvs, vcpkg-installed libraries, Go
workspaces) lives under `envs/<project>/`.

:::note
**No sudo. No root. No system directories.** Compendium only writes under
`~/.local/compendium/`.
:::

## What's next

- Building a C or C++ project? See the [C/C++ project guide](/guides/cpp-project/). There are a few platform-specific caveats worth knowing.
- Want to see every tool and version the registry currently offers? See [Available tools](/reference/available-tools/).
- Want the full CLI surface? See the [CLI reference](/reference/cli/).
