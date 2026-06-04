---
title: Frequently Asked Questions (FAQ)
description: Common questions about Compendium and how it compares to other tools.
---

Common questions about Compendium and how it compares to other tools. Short answers; the docs cover the details.

## Why not Nix?

Nix is more powerful and more general. It can do everything Compendium does and more: true hermetic builds, full OS management, atomic rollbacks. But it asks a lot of you up front: the Nix language, the store model, flakes.

Compendium is narrower on purpose. One TOML, one Go binary, learnable in five minutes. Curated prebuilt binaries from upstream rather than building from source. First-class support for embedded toolchains (arm-none-eabi-gcc, OpenOCD, vcpkg), which are doable in Nix but painful.

**Short version:** Nix if you want the deepest reproducibility and don't mind the curve. Compendium if you want your team productive same-day with a TOML and a single binary.

## Why not Docker or Podman?

Containers solve a different problem, and the two compose fine. Docker is genuinely great for resurrecting old projects where the only thing you can pin is "Ubuntu 18.04 era and pray," and for OS-level isolation when you need a deployable artifact.

Compendium is for projects you're actively developing today, where you want a fast native dev loop, USB access for boards, and a TOML in the repo that future-you (or a new teammate) can clone and be productive on in five minutes without spinning up a container.

**Short version:** Docker to revive legacy projects or ship images. Compendium to manage the active ones.

## Why not devcontainers?

Fair use case for Docker. Devcontainers achieve project isolation through the container.

Compendium achieves the same outcome through version-namespaced directories and PATH management. Same per-project isolation, no container overhead, native USB access, native filesystem speed, and not coupled to one editor's ecosystem.

**Short version:** Devcontainers if your team is locked into VS Code and Docker. Compendium if you want the same reproducibility without the container layer or the editor lock-in.

## Why not asdf or mise?

asdf and mise are great at managing scripting-language runtimes. Both handle Node, Python, Ruby, and Go well. If that covers everything you need, they're solid choices.

The gap is compilers. None of them seriously handle GCC, Clang, arm-none-eabi-gcc, or riscv-none-elf-gcc, which is exactly where setup pain runs deepest. Compendium treats compilers and embedded toolchains as first-class citizens, the same way asdf treats Node.

**Short version:** asdf or mise if you only work in scripting languages. Compendium if your project touches C, C++, or embedded.

## Why not Homebrew?

Homebrew installs the latest version of whatever it has, on a system-wide path, shared by every project on your machine. That's the opposite of what reproducible environments need. Two projects that need different Go versions, or different CMake versions, can't both be happy with Homebrew.

Compendium pins per project. Different projects, different toolchains, no conflicts, no sudo, nothing in `/usr/local/`.

**Short version:** Homebrew for system tools. Compendium for project toolchains.

## Why not a Makefile or setup script?

A setup script is exactly what Compendium is replacing. Every team has one and they all rot the same way. They install whatever the package manager has today, which drifts from what worked yesterday. They break on a fresh laptop because the dependency the script assumed isn't there. They're written for one OS and silently fail on another. They get stale faster than the README that documents them.

Compendium gives you the same outcome (a working environment from a fresh clone), but the versions are pinned, verified by checksum, and consistent across macOS and Linux.

**Short version:** A setup script is a TODO list of things to install. Compendium is a contract.

## Won't projects with different dependencies conflict?

No, by design.

Each project pins versions in its own `compendium.toml`. Installs live under `~/.local/compendium/` in version-namespaced folders (`languages/go/1.26.1/`, `tools/cmake/4.3.1/`). Same version across projects means one shared install. Different versions means different folders, no conflict.

Per-project state (Python venvs, vcpkg libraries, Go workspaces) lives under `envs/<project>/`, fully isolated. Activate prepends the current project's paths to PATH; deactivate restores. Switching projects is `cd` plus `source <(compendium activate)`.

## Does this replace my existing version manager?

For the languages and tools Compendium covers, yes. For tools it doesn't cover, no, keep using what works. Compendium isn't trying to be the only thing on your PATH; it's trying to be the source of truth for the toolchain your project actually depends on.

In practice, most people delete their nvm, pyenv, or asdf setup for projects that use Compendium, and keep them around for ad-hoc work on personal projects that don't have a `compendium.toml`. Both can coexist.

## Does it work on Windows?

Not currently. macOS and Linux only. The Windows toolchain landscape (MSVC, WSL, MSYS2, vcpkg's Windows tree) is its own world, and supporting it well would mean a lot of work that doesn't help the C/C++ and embedded Linux/macOS users who are the current focus.

WSL should work since that's Linux underneath, though it hasn't been tested yet. Native Windows support is something to revisit once the Linux and macOS story is more mature.
