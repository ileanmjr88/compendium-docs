---
title: "ADR 0001: Relicense to Apache-2.0"
description: Relicense the Compendium CLI from GPL-3.0 to Apache-2.0.
---

## Status
Accepted (2026-11-14). Applies from v0.1.2.

## Context
The goal is to make adoption easy for both individuals and companies. GPL-3.0 does a great job of keeping software open, but it creates friction: many companies and regulated teams can't use GPL tools.

I am the sole copyright holder of the CLI, so I can change its license.

## Decision
Starting with v0.1.2, the Compendium CLI is licensed under Apache-2.0. Attribution is kept through the `NOTICE` file.

## Consequences
- Companies and regulated teams can adopt the CLI without GPL concerns.
- v0.1.1 and earlier stay under GPL-3.0.
- Release archives now include `LICENSE`, `NOTICE`, and `third_party_licenses/`.
