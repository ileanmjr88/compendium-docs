---
title: "ADR 0001: Cambio de licencia a Apache-2.0"
description: Cambio de licencia de la CLI de Compendium de GPL-3.0 a Apache-2.0.
---

## Estado
Aceptada (2026-11-14). Vigente a partir de la v0.1.2.

## Contexto
El objetivo es facilitar la adopción tanto para personas como para empresas. GPL-3.0 cumple muy bien su función de mantener el software abierto, pero genera fricción: muchas empresas y equipos en sectores regulados no pueden usar herramientas con licencia GPL.

Soy el único titular de los derechos de autor de la CLI, por lo que puedo cambiar su licencia.

## Decisión
A partir de la v0.1.2, la CLI de Compendium se distribuye bajo la licencia Apache-2.0. La atribución se conserva mediante el archivo `NOTICE`.

## Consecuencias
- Las empresas y los equipos en sectores regulados pueden adoptar la CLI sin preocupaciones relacionadas con la GPL.
- La v0.1.1 y las versiones anteriores siguen bajo GPL-3.0.
- Los archivos comprimidos de cada versión publicada ahora incluyen `LICENSE`, `NOTICE` y `third_party_licenses/`.
