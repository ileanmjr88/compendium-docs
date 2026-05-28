// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightLlmsTxt from 'starlight-llms-txt';

// https://astro.build/config
export default defineConfig({
  site: "https://compendium.ilean.me",
  integrations: [
    starlight({
      title: "Compendium",
      description:
        "Reproducible developer environments, declared in one config.",
      plugins: [starlightLlmsTxt()],
      head: [
        {
          tag: "script",
          attrs: {
            src: "https://cloud.umami.is/script.js",
            "data-website-id": "0954ee19-b1a1-423c-8e58-24e935bc846e",
            defer: true,
          },
        },
      ],
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/ileanmjr88/compendium",
        },
      ],
      sidebar: [
        { label: "About", slug: "about" },
        {
          label: "Getting started",
          items: [
            { label: "Installing", slug: "getting-started/installation" },
            { label: "First steps", slug: "getting-started/first-steps" },
            { label: "AI Tooling", slug: "getting-started/ai-tooling" },
          ],
        },
        {
          label: "Guides",
          items: [{ autogenerate: { directory: "guides" } }],
        },
        {
          label: "Reference",
          items: [{ autogenerate: { directory: "reference" } }],
        },
        { label: "Roadmap", slug: "roadmap" },
        {
          label: "Acknowledgement",
          slug: "acknowledge",
        },
      ],
    }),
  ],
});
