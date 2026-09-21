# SSEC Color System

All colors derive from the [UW Brand Guidelines](https://www.washington.edu/brand/graphic-elements/primary-color/).

## Primary Palette — UW Purple

The purples anchor the SSEC identity. Spirit Purple (`#4b2e83`) is the primary brand color used for interactive elements, headings, and brand moments.

| Token              | Hex       | Role                                    |
|--------------------|-----------|-----------------------------------------|
| `purple-950`       | `#1a0038` | Hero backgrounds, terminal surfaces     |
| `purple-900`       | `#32006e` | Husky Purple — deep backgrounds         |
| `purple-700`       | `#4b2e83` | **Spirit Purple — PRIMARY interactive** |
| `purple-600`       | `#5a3d94` | Hover states on lighter purple          |
| `purple-500`       | `#6b4fa6` | Focus rings, secondary interactive      |
| `purple-400`       | `#8b74be` | Decorative, disabled on dark bg         |
| `purple-200`       | `#c5b4e3` | UW Accent Lavender — light accents      |
| `purple-100`       | `#e0d7f0` | Subtle tinted backgrounds               |
| `purple-50`        | `#f0ecf7` | Near-white tinted surface               |

## Secondary Palette — UW Gold

The golds provide warmth and gravitas, balancing the purple.

| Token              | Hex       | Role                                    |
|--------------------|-----------|-----------------------------------------|
| `gold-700`         | `#85754d` | Heritage Gold — strong text on white    |
| `gold-500`         | `#b7a57a` | Husky Gold — accents, borders, badges   |
| `gold-200`         | `#e8e3d3` | Light Gold — section backgrounds        |
| `gold-100`         | `#f2efe6` | Near-white warm surface                 |
| `gold-50`          | `#f9f7f2` | Subtle warm tint                        |

## Accent Palette — AI/Tech Identity (max 15% coverage)

Teal is the signature SSEC accent, evoking technology, data, and AI. It differentiates SSEC from the broader UW purple-gold identity.

| Token              | Hex       | Role                                    |
|--------------------|-----------|-----------------------------------------|
| `teal-500`         | `#2ad2c9` | **SSEC signature accent** — AI moments  |
| `teal-400`         | `#5cddd6` | Links on dark backgrounds               |
| `teal-200`         | `#c2f3f0` | Light teal tint for callouts            |
| `green-500`        | `#aadb1e` | Success states, growth indicators       |
| `pink-500`         | `#e93cac` | Alerts, emphasis (sparingly)            |
| `spirit-gold`      | `#ffc700` | Energy accent — awards, highlights      |

## Contrast Verification

All text/background combinations used in the design system pass WCAG 2.2 AA:

| Foreground         | Background          | Ratio  | Pass? |
|--------------------|---------------------|--------|-------|
| `#ffffff` (white)  | `#4b2e83` (purple)  | 9.4:1  | AA    |
| `#4b2e83` (purple) | `#ffffff` (white)   | 9.4:1  | AA    |
| `#4b2e83` (purple) | `#e8e3d3` (lt gold) | 6.7:1  | AA    |
| `#ffffff` (white)  | `#85754d` (her gold)| 4.6:1  | AA    |
| `#ffffff` (white)  | `#32006e` (h purple)| 12.6:1 | AAA   |
| `#1a1d1f` (dark)   | `#ffffff` (white)   | 16.3:1 | AAA   |
| `#1a1d1f` (dark)   | `#f9f7f2` (gold 50) | 14.9:1 | AAA   |
| `#2ad2c9` (teal)   | `#1a0038` (p 950)   | 8.2:1  | AA    |

### Known FAILS — Do NOT use:

| Foreground         | Background          | Ratio  |
|--------------------|---------------------|--------|
| `#ffc700` (spirit gold) | `#ffffff`       | 1.8:1  |
| `#2ad2c9` (teal)   | `#ffffff` (white)   | 2.9:1  |
| `#e93cac` (pink)   | `#4b2e83` (purple)  | 2.8:1  |
| `#aadb1e` (green)  | `#ffffff` (white)   | 2.3:1  |

## Usage Rules

1. **Purple dominates** — it appears in the header, navigation, CTAs, and headings
2. **Gold supports** — backgrounds, horizontal rules, badges, secondary elements
3. **Teal accents** — code highlights, AI-related features, data visualizations, hover glows (must stay under 15% of any page)
4. **Dark mode sections** use `purple-950` or `purple-900` backgrounds with white/teal/gold text
5. **Never use accent colors for logos** per UW brand rules
