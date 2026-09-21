# SSEC Typography System

## Font Stack

| Role        | Font                      | Fallback                                           | Usage                                    |
|-------------|---------------------------|----------------------------------------------------|------------------------------------------|
| **Display** | Encode Sans               | -apple-system, BlinkMacSystemFont, Segoe UI, Roboto | Page titles, hero headings, section headings |
| **UI**      | Encode Sans Compressed    | Encode Sans, system sans-serif                      | Buttons, navigation, labels, tags        |
| **Body**    | Open Sans                 | -apple-system, BlinkMacSystemFont, Segoe UI, Roboto | Paragraphs, descriptions, long-form text |
| **Code**    | JetBrains Mono            | Fira Code, Source Code Pro, Consolas, monospace      | Code blocks, terminal UI, data values    |

### Font Loading Strategy

Load from Google Fonts with `display=swap` for performance:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Encode+Sans:wght@300;400;500;600;700;800&family=Encode+Sans+Compressed:wght@400;600;700&family=Open+Sans:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

## Type Scale

Fluid sizing using `clamp()` for responsive behavior without breakpoints.

| Token       | Min (mobile) | Max (desktop) | Line Height | Use Case                        |
|-------------|-------------|---------------|-------------|----------------------------------|
| `text-xs`   | 12px        | 13px          | 1.5         | Captions, footnotes, timestamps  |
| `text-sm`   | 14px        | 15px          | 1.5         | Labels, helper text, metadata    |
| `text-base` | 16px        | 17px          | 1.5–1.625   | Body text, descriptions          |
| `text-lg`   | 18px        | 20px          | 1.5         | Lead paragraphs, card titles     |
| `text-xl`   | 20px        | 24px          | 1.3         | H4 headings, feature titles      |
| `text-2xl`  | 24px        | 32px          | 1.3         | H3 headings, section titles      |
| `text-3xl`  | 30px        | 40px          | 1.15        | H2 headings, page sections       |
| `text-4xl`  | 36px        | 48px          | 1.15        | H1 headings, page titles         |
| `text-5xl`  | 44px        | 60px          | 1.05        | Hero headlines                   |

## Heading Styles

```
H1  — Encode Sans, 800 weight, text-4xl, tracking-tight, leading-tight
H2  — Encode Sans, 700 weight, text-3xl, tracking-tight, leading-tight
H3  — Encode Sans, 600 weight, text-2xl, tracking-normal, leading-snug
H4  — Encode Sans, 600 weight, text-xl, tracking-normal, leading-snug
H5  — Encode Sans Compressed, 600 weight, text-lg, tracking-wide, leading-snug
H6  — Encode Sans Compressed, 600 weight, text-base, tracking-wider, leading-normal
```

## Body Styles

```
Body       — Open Sans, 400 weight, text-base, leading-relaxed
Body Small — Open Sans, 400 weight, text-sm, leading-normal
Lead       — Open Sans, 400 weight, text-lg, leading-relaxed
Caption    — Open Sans, 400 weight, text-xs, leading-normal
```

## Special Styles

```
Code Inline  — JetBrains Mono, 500 weight, text-sm, purple-50 bg, purple-700 text
Code Block   — JetBrains Mono, 400 weight, text-sm, purple-950 bg, teal-500 text
Label        — Encode Sans Compressed, 600 weight, text-sm, tracking-wider, uppercase
Tag          — Encode Sans Compressed, 600 weight, text-xs, tracking-widest, uppercase
Stat Number  — Encode Sans, 800 weight, text-5xl, tracking-tighter (for hero metrics)
```

## Rules

1. **Never use more than 2 font families on a single page** (display + body, or compressed + body)
2. **Code font is additive** — it doesn't count against the 2-family limit
3. **Minimum body text size: 16px** for accessibility
4. **Maximum line length: 75 characters** for readability
5. **Heading hierarchy must be sequential** — never skip heading levels
