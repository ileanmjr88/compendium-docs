# Cómo contribuir a la documentación de Compendium

> 🌐 [English](./CONTRIBUTING.md) · **Español**

Gracias por considerar una contribución. Este repositorio contiene el código fuente de [compendium.ilean.me](https://compendium.ilean.me). Si encontró un error de tipeo, un enlace roto, un ejemplo desactualizado, o quiere agregar una guía nueva, está en el lugar correcto.

Para reportar errores de la **CLI de Compendium** en sí (no de la documentación), abra un issue en [ileanmjr88/compendium](https://github.com/ileanmjr88/compendium/issues).

## Ediciones rápidas (tipeo, redacción, enlace roto)

Para correcciones de una línea, la vía más rápida es el enlace «Editar en GitHub» al pie de cualquier página (si está habilitado), o simplemente edite el archivo directamente en GitHub y deje que abra un pull request por usted. No necesita configuración local.

## Cambios mayores (página nueva, sección nueva, reestructuración)

Clone el repositorio y ejecútelo localmente:

```bash
git clone https://github.com/ileanmjr88/compendium-docs.git
cd compendium-docs
npm install
npm run dev
```

El servidor de desarrollo se ejecuta en `http://localhost:4321` con recarga automática.

### Dónde está cada cosa

- Todas las páginas de documentación están en [`src/content/docs/`](./src/content/docs/) como `.md` o `.mdx`.
- Cada nombre de archivo se convierte en una URL (p. ej. `about.mdx` → `/about`).
- El orden de la barra lateral se define en [`astro.config.mjs`](./astro.config.mjs). Las carpetas `guides/` y `reference/` incluyen automáticamente cualquier página nueva; About, Roadmap y Acknowledgement se listan de forma explícita.
- Las imágenes van en `src/assets/` y se referencian con rutas relativas desde MDX.

### Agregar una página nueva

1. Cree un archivo en la carpeta correspondiente (p. ej. `src/content/docs/guides/mi-guia-nueva.mdx`).
2. Incluya el frontmatter al inicio:
   ```yaml
   ---
   title: Mi guía nueva
   description: Descripción de una línea usada para SEO y vistas previas de enlaces.
   ---
   ```
3. Si la página está bajo `guides/` o `reference/`, aparecerá en la barra lateral automáticamente. Para cualquier otra ubicación, agréguela al arreglo `sidebar` en `astro.config.mjs`.
4. Ejecute `npm run build` antes de abrir el PR para confirmar que no haya enlaces rotos ni errores de compilación.

## Notas de estilo

- Prefiera prosa sencilla en vez de jerga. El público son desarrolladores que pueden ser nuevos en las herramientas de entornos de desarrollo.
- Muestre los comandos completos, no abreviados. `npm install`, no `npm i`.
- Al mostrar `compendium.toml`, use números de versión realistas, no `latest`.
- Mantenga la voz de las páginas existentes: directa, práctica, sin relleno de marketing.
- Mantenga los párrafos cortos.

### Traducciones al español

La documentación es bilingüe: el inglés vive en la raíz y el español bajo [`src/content/docs/es/`](./src/content/docs/es/), reflejando el mismo árbol de archivos. Al traducir o corregir el español:

- Use el registro formal **usted** («Instale Compendium, luego ejecute `compendium activate`»).
- Use **español latinoamericano neutro** (p. ej. *archivo* en vez de *fichero*, *computadora* en vez de *ordenador*).
- Respete el glosario: *entorno* (no *ambiente*), *biblioteca* (no *librería*), *fiable/fiabilidad* (no *estabilidad*), *seleccionadas* para «curated».
- No traduzca comandos, flags, rutas, identificadores ni la salida de los programas; sí traduzca los comentarios en lenguaje natural dentro de los bloques de código.
- Prefije los enlaces internos del cuerpo con `/es/`.

Para enviar una corrección de gramática o traducción, use la plantilla de PR en español agregando `?template=correccion-gramatical.md&expand=1` a la URL del pull request.

## Qué está dentro del alcance

Bienvenido:
- Correcciones de tipeo y gramática
- Explicaciones más claras de conceptos existentes
- Guías nuevas para lenguajes o frameworks aún no cubiertos
- Mejores ejemplos
- Correcciones de flags o salida desactualizados de la CLI

Fuera del alcance aquí (regístrelos en otro lugar):
- Errores en la CLI de Compendium → [ileanmjr88/compendium](https://github.com/ileanmjr88/compendium/issues)
- Herramientas nuevas en el registry → [ileanmjr88/compendium-registry](https://github.com/ileanmjr88/compendium-registry)
- Solicitudes de funcionalidades para la CLI → [GitHub Discussions de Compendium](https://github.com/ileanmjr88/compendium/discussions)

## Enviar un pull request

1. Haga un fork del repositorio y cree una rama a partir de `main`.
2. Haga sus cambios. Ejecute `npm run build` para confirmar que el sitio sigue compilando.
3. Abra un PR con un título corto y una descripción de un párrafo sobre qué cambió y por qué.
4. CI desplegará una compilación de vista previa si está configurada. Quienes revisen pueden sugerir cambios antes de hacer merge.

## Preguntas

Para cualquier cosa que no encaje en un PR o un issue, inicie un hilo en [GitHub Discussions](https://github.com/ileanmjr88/compendium/discussions).
