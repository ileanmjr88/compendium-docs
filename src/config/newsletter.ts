/**
 * Newsletter signup configuration.
 *
 * The docs site is a static build served from Cloudflare Workers assets, so the
 * form posts directly to Buttondown rather than to an endpoint of our own. The
 * account and the working form shape are shared with ileanmjr88.github.io —
 * see `src/components/SubscribeCTA.astro` there before changing anything here.
 */

/** Buttondown account that owns the list. One account, many newsletters. */
export const BUTTONDOWN_USERNAME = 'ilean';

/** Where the form posts. */
export const ACTION = `https://buttondown.com/api/emails/embed-subscribe/${BUTTONDOWN_USERNAME}`;

/** Name of the email input Buttondown expects. */
export const EMAIL_FIELD = 'email';

/**
 * Buttondown is one newsletter on the Basic plan, so tags are what separate the
 * compendium docs list from the ileanmjr88.github.io blog list (which tags
 * subscribers `en` / `es` and filters its RSS-to-email feeds on exactly those
 * names). Anything sent from this site is tagged `compendium` and matches no
 * blog feed. The tag is captured at signup and can never be backfilled, so it
 * must be on every form this site renders.
 *
 * One tag, deliberately — not `compendium-en` / `compendium-es`. Every issue
 * goes out in both English and Spanish, so there is nothing to route on and the
 * Spanish pages submit the same tag as the English ones.
 */
export const TAG = 'compendium';

/** Referral link behind the "Powered by Buttondown" line. */
export const POWERED_BY_URL = `https://buttondown.com/refer/${BUTTONDOWN_USERNAME}`;
