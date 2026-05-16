# Compendium documentation

Source for [compendium.ilean.me](https://compendium.ilean.me), the documentation site for [Compendium](https://github.com/ileanmjr88/compendium).

Built with [Astro](https://astro.build) and [Starlight](https://starlight.astro.build). Deployed to Cloudflare Workers.

## Local development

This repo dogfoods Compendium itself. If you have Compendium installed, the toolchain pins live in [`compendium.toml`](./compendium.toml) (Node 22.22.2, pnpm 10.33.4).

```bash
npm install
npm run dev      # http://localhost:4321
```

## Project layout

| Path                  | Purpose                                            |
| --------------------- | -------------------------------------------------- |
| `src/content/docs/`   | All documentation pages (`.md` / `.mdx`)           |
| `src/assets/`         | Images referenced from docs                        |
| `public/`             | Static assets served at the site root              |
| `astro.config.mjs`    | Astro + Starlight config, including sidebar order  |
| `wrangler.jsonc`      | Cloudflare Workers deploy config                   |
| `compendium.toml`     | Toolchain pins for local development               |

## Scripts

| Command             | What it does                              |
| ------------------- | ----------------------------------------- |
| `npm run dev`       | Start the local dev server                |
| `npm run build`     | Build the static site to `./dist/`        |
| `npm run preview`   | Preview the production build locally      |
| `npm run astro ...` | Pass through to the Astro CLI             |

## Deployment

Pushes to `main` trigger a Cloudflare Workers build that runs `npm run build` and deploys `./dist/` to `compendium.ilean.me` (with the `compendium-docs.ileanmjr.workers.dev` URL as a fallback).

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for how to suggest edits, report issues, or open a pull request.
