# Documentación de Compendium

> 🌐 [English](./README.md) · **Español**

Código fuente de [compendium.ilean.me](https://compendium.ilean.me), el sitio de documentación de [Compendium](https://github.com/ileanmjr88/compendium).

Construido con [Astro](https://astro.build) y [Starlight](https://starlight.astro.build). Desplegado en Cloudflare Workers.

## Desarrollo local

Este repositorio usa Compendium para su propio desarrollo. Si tiene Compendium instalado, las versiones fijadas del toolchain están en [`compendium.toml`](./compendium.toml) (Node 22.22.2, pnpm 10.33.4).

```bash
npm install
npm run dev      # http://localhost:4321
```

## Estructura del proyecto

| Ruta                  | Propósito                                          |
| --------------------- | -------------------------------------------------- |
| `src/content/docs/`   | Todas las páginas de documentación (`.md` / `.mdx`)|
| `src/components/`     | Componentes de Astro usados desde las páginas MDX  |
| `src/config/`         | Módulos de configuración pequeños (p. ej. el proveedor del boletín) |
| `src/assets/`         | Imágenes referenciadas desde la documentación      |
| `public/`             | Recursos estáticos servidos en la raíz del sitio   |
| `astro.config.mjs`    | Configuración de Astro + Starlight, incluido el orden de la barra lateral |
| `wrangler.jsonc`      | Configuración de despliegue en Cloudflare Workers  |
| `compendium.toml`     | Versiones fijadas del toolchain para el desarrollo local |

## Scripts

| Comando             | Qué hace                                  |
| ------------------- | ----------------------------------------- |
| `npm run dev`       | Inicia el servidor de desarrollo local    |
| `npm run build`     | Compila el sitio estático en `./dist/`    |
| `npm run preview`   | Previsualiza localmente la compilación de producción |
| `npm run astro ...` | Pasa los argumentos a la CLI de Astro     |

## Despliegue

Los push a `main` activan una compilación en Cloudflare Workers que ejecuta `npm run build` y despliega `./dist/` en `compendium.ilean.me` (con la URL `compendium-docs.ileanmjr.workers.dev` como respaldo).

## Cómo contribuir

Consulte [CONTRIBUTING.es.md](./CONTRIBUTING.es.md) para saber cómo sugerir cambios, reportar problemas o abrir un pull request.
