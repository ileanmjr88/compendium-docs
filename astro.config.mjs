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
      defaultLocale: "root",
      locales: {
        root: { label: "English", lang: "en" },
        es: { label: "Español", lang: "es" },
      },
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
        { label: "About", translations: { es: "Acerca de" }, slug: "about" },
        {
          label: "Getting started",
          translations: { es: "Primeros pasos" },
          items: [
            {
              label: "Installing",
              translations: { es: "Instalación" },
              slug: "getting-started/installation",
            },
            {
              label: "First steps",
              translations: { es: "Primeros pasos" },
              slug: "getting-started/first-steps",
            },
            {
              label: "AI Tooling",
              translations: { es: "Herramientas de IA" },
              slug: "getting-started/ai-tooling",
            },
          ],
        },
        {
          label: "Guides",
          translations: { es: "Guías" },
          items: [{ autogenerate: { directory: "guides" } }],
        },
        {
          label: "Reference",
          translations: { es: "Referencia" },
          items: [{ autogenerate: { directory: "reference" } }],
        },
        { label: "FAQ", translations: { es: "Preguntas frecuentes" }, slug: "faq" },
        { label: "Roadmap", translations: { es: "Hoja de ruta" }, slug: "roadmap" },
        {
          label: "Acknowledgement",
          translations: { es: "Agradecimientos" },
          slug: "acknowledge",
        },
      ],
    }),
  ],
});
