# Contributing to the Compendium docs

Thanks for considering a contribution. This repo holds the source for [compendium.ilean.me](https://compendium.ilean.me). If you spotted a typo, a broken link, an outdated example, or you want to add a new guide, you're in the right place.

For bug reports about the **Compendium CLI itself** (not the docs), open an issue on [ileanmjr88/compendium](https://github.com/ileanmjr88/compendium/issues) instead.

## Quick edits (typo, wording, broken link)

For one-line fixes, the fastest path is the "Edit on GitHub" link at the bottom of any page (if enabled), or just edit the file directly on GitHub and let it open a pull request for you. No local setup needed.

## Bigger changes (new page, new section, restructuring)

Clone the repo and run it locally:

```bash
git clone https://github.com/ileanmjr88/compendium-docs.git
cd compendium-docs
npm install
npm run dev
```

The dev server runs at `http://localhost:4321` with hot reload.

### Where things live

- All docs pages are in [`src/content/docs/`](./src/content/docs/) as `.md` or `.mdx`.
- Each filename becomes a URL (e.g. `about.mdx` → `/about`).
- The sidebar order is defined in [`astro.config.mjs`](./astro.config.mjs). Guides and Reference auto-include any new page in their folders; About, Roadmap, and Acknowledgement are listed explicitly.
- Images go in `src/assets/` and are referenced with relative paths from MDX.

### Adding a new page

1. Create a file in the appropriate folder (e.g. `src/content/docs/guides/my-new-guide.mdx`).
2. Include frontmatter at the top:
   ```yaml
   ---
   title: My new guide
   description: One-line description used for SEO and link previews.
   ---
   ```
3. If the page is under `guides/` or `reference/`, it will appear in the sidebar automatically. For anywhere else, add it to the `sidebar` array in `astro.config.mjs`.
4. Run `npm run build` before opening the PR to confirm there are no broken links or build errors.

## Style notes

- Prefer plain prose over jargon. The audience is developers who may be new to dev-environment tooling.
- Show full commands, not abbreviated ones. `npm install`, not `npm i`.
- When demonstrating `compendium.toml`, use realistic version numbers, not `latest`.
- Match the voice of the existing pages: direct, practical, no marketing fluff.
- Keep paragraphs short.

## What's in scope

Welcome:
- Typo and grammar fixes
- Clearer explanations of existing concepts
- New guides for languages or frameworks not yet covered
- Better examples
- Fixes for outdated CLI flags or output

Not in scope here (file these elsewhere):
- Bugs in the Compendium CLI → [ileanmjr88/compendium](https://github.com/ileanmjr88/compendium/issues)
- New tools in the registry → [ileanmjr88/compendium-registry](https://github.com/ileanmjr88/compendium-registry)
- Feature requests for the CLI → [Compendium GitHub Discussions](https://github.com/ileanmjr88/compendium/discussions)

## Submitting a pull request

1. Fork the repo and create a branch off `main`.
2. Make your changes. Run `npm run build` to confirm the site still builds.
3. Open a PR with a short title and a one-paragraph description of what changed and why.
4. CI will deploy a preview build if configured. Reviewers may suggest edits before merging.

## Questions

For anything that doesn't fit a PR or an issue, start a thread in [GitHub Discussions](https://github.com/ileanmjr88/compendium/discussions).
