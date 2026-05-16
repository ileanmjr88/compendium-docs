// Resolved at build time. If the GitHub API can't be reached (offline build,
// rate limit, repo not yet public), falls back to FALLBACK_VERSION. Keep that
// in sync with the latest shipped tag so the docs degrade gracefully.

const FALLBACK_VERSION = "v0.1.0";
const REPO = "ileanmjr88/compendium";

async function fetchLatestTag(): Promise<string> {
  try {
    const res = await fetch(
      `https://api.github.com/repos/${REPO}/releases/latest`,
      { headers: { "User-Agent": "compendium-docs" } },
    );
    if (!res.ok) return FALLBACK_VERSION;
    const data = (await res.json()) as { tag_name?: string };
    return data.tag_name ?? FALLBACK_VERSION;
  } catch {
    return FALLBACK_VERSION;
  }
}

export const latestVersion = await fetchLatestTag();
