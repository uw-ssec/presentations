---
type: Decision
title: "Partner Logo Lockup: SSEC, eScience, UW on Every Slide"
description: "Every slide carries an SSEC, eScience Institute and University of Washington lockup top-right, injected once from the deck footer, greyed back on content slides and knocked out to white on dark ones, with the SVGs copied into the deck from uwssec.org"
tags: [branding, logos, assets, uw-slides]
generated: { by: "claude-code:claude-opus-5", at: "2026-09-23T15:45:54Z" }
status: stable
governance: constraint
code_refs: [from-hand-coding-to-ai-orchestration/shared/footer.html, from-hand-coding-to-ai-orchestration/shared/slide-base.css, "from-hand-coding-to-ai-orchestration/assets/logos/*.svg"]
---

Every slide carries a partner logo lockup in the order **SSEC, then the eScience
Institute, then the University of Washington**, placed in the top-right corner.
Every slide uses the same corner treatment, including the closing slides.

## Where the assets come from

Upstream is the SSEC website, `https://uwssec.org/images/...`:

| Local file under `<deck>/assets/logos/` | Upstream path |
| --------------------------------------- | -------------- |
| `uw_ssec_logo.svg` | `/images/logo/uw_ssec_logo.svg` |
| `uw_ssec_logo_white.svg` | `/images/logo/uw_ssec_logo_white.svg` |
| `escience_institute.svg` | `/images/partners/escience_institute.svg` |
| `university_of_washington_2.svg` | `/images/partners/university_of_washington_2.svg` |

Copy them into the deck rather than hotlinking: decks are presented from
`file://` and archived on Zenodo, so a remote reference would leave the lockup
blank offline and in the PDF.

**Only those four exist.** `uw_ssec_logo_black.svg`, `_color.svg` and
`_dark.svg` all answer **HTTP 200 with the site's `index.html`** because the
site is a SPA with a catch-all fallback, the same trap recorded for this
repository's own Cloudflare Pages deployment. Check `content-type` (or the
first bytes) rather than the status code before trusting that a logo variant
exists.

## How they are added to a slide

The lockup is injected into every `section.slide` by `shared/footer.html`, so
the order and markup are defined once instead of pasted into every fragment.
Styles live in `shared/slide-base.css` under `.partner-logos`; slide-specific
offsets belong in that slide's own fragment.

- The three marks differ in aspect ratio (3.33:1, 4.15:1, 4.64:1), so they are
  normalised by **height**, not width. The SSEC wordmark reads optically
  smaller and is set taller than the other two.
- Content slides get `is-muted`: greyscale at 55% opacity, waking to full brand
  colour on hover.
- Dark slides knock the lockup out to white with `filter: brightness(0)
  invert(1)` and stay white on hover. Brand purple (`#4b2e83`, `#443374`) on a
  dark purple ground is close to invisible, so colour is never revealed there.
- The title, thank-you and questions slides show the lockup at full strength
  with no hover gesture.
- A larger lockup centred on the closing slide was built and then **rejected**:
  the corner mark has to be in the same place on every slide, and a centred
  variant reads as a different element rather than the same furniture.
- Paper has no hover, so an `@media print` block prints every lockup at full
  strength.

## Placement is verified, not assumed

One collision survives and is fixed with a rule in the fragment: the title
slide's full-screen icon owns the top-right corner, so the lockup sits inboard
of it. A second was found while the centred closing variant existed - it sat on
the gold angle divider - and disappeared with that variant, but the lesson it
taught about scanning did not.

Scan the boxes as described in the slide visual verification concept, and
include **elements that merely paint** - decorative divs, bands, dividers -
not just text and images. A scan limited to `h1..p, img, figure` reported a
clean pass while the closing lockup sat on top of the angle divider.

## Related Concepts
- [SSEC is the default slide brand, adapted from the website design system](ssec-slide-brand.md): The lockup is part of the SSEC slide brand and uses its spacing tokens and colour palette
- [Verifying a slide change visually: nothing outside the 1280x720 boundary](../project/slide-visual-verification.md): Placing the lockup needs this verification method, extended to elements that merely paint such as decorative bands and dividers
- [Deck-level presenter controls live in shared/footer.html: walkthrough keys, progress bar, full-screen toggle](../from-hand-coding-to-ai-orchestration/presenter-controls.md): The footer injects the lockup into every slide alongside the deck controls it already owns
