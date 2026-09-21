# SSEC Spacing & Layout System

## Spacing Scale

Base unit: **4px** (`0.25rem`). All spacing values are multiples of 4px.

| Token       | Value   | px   | Use Case                                      |
|-------------|---------|------|-----------------------------------------------|
| `space-0-5` | 0.125rem| 2px  | Tight inline gaps (icon nudges)               |
| `space-1`   | 0.25rem | 4px  | Icon-to-text gap, tight inner padding         |
| `space-1-5` | 0.375rem| 6px  | Badge padding                                 |
| `space-2`   | 0.5rem  | 8px  | Default inline padding, related element gap   |
| `space-3`   | 0.75rem | 12px | Comfortable inline padding, input padding     |
| `space-4`   | 1rem    | 16px | Default block spacing, card inner padding     |
| `space-5`   | 1.25rem | 20px | Medium block spacing                          |
| `space-6`   | 1.5rem  | 24px | UW block gap — card padding, group separation |
| `space-8`   | 2rem    | 32px | Major element separation                      |
| `space-10`  | 2.5rem  | 40px | Large separation                              |
| `space-12`  | 3rem    | 48px | Section padding (small)                       |
| `space-16`  | 4rem    | 64px | Section padding (medium)                      |
| `space-20`  | 5rem    | 80px | Section padding (large)                       |
| `space-24`  | 6rem    | 96px | Hero section padding                          |
| `space-32`  | 8rem    | 128px| Maximum section separation                    |

## Layout Widths

| Token          | Value   | Use Case                              |
|----------------|---------|---------------------------------------|
| `width-content`| 960px   | Default content container (UW)        |
| `width-wide`   | 1140px  | Wide content (cards grid, features)   |
| `width-full`   | 1400px  | Full-bleed hero sections              |

## Grid System

### Page Grid

```
Container: max-width var(--width-wide), centered with auto margins
Gutter: var(--space-6) = 24px (UW standard)
Columns: 12-column fluid grid
```

### Content Layouts

| Layout          | Columns                  | Use Case                              |
|-----------------|--------------------------|---------------------------------------|
| Single column   | 1fr (max 75ch)           | Articles, about pages, long-form text |
| Two column      | 1fr 1fr                  | Features, project cards               |
| Three column    | repeat(3, 1fr)           | Team grid, product cards              |
| Four column     | repeat(4, 1fr)           | Stats bar, icon features              |
| Sidebar layout  | 1fr 320px                | Project detail, filtered listings     |
| Asymmetric      | 2fr 1fr or 1fr 2fr       | Hero content + media                  |

### Responsive Breakpoints

| Name    | Value   | Columns | Container Padding |
|---------|---------|---------|-------------------|
| Mobile  | < 640px | 1       | `space-4` (16px)  |
| Tablet  | 640px   | 2       | `space-6` (24px)  |
| Desktop | 1024px  | 3–4     | `space-8` (32px)  |
| Wide    | 1280px  | 4       | `space-8` (32px)  |

### The 15-Degree Motif

The UW brand uses a **15-degree angle** throughout its graphic elements (Boundless Bar, Angled Rain, Block W serifs). SSEC uses this angle as a subtle structural element:

- **Section dividers**: Angled clip-path transitions between sections at 15 degrees
- **Decorative borders**: Thin lines at 15 degrees behind hero text
- **Background textures**: Subtle angled rain pattern on dark sections
- **Card hover states**: Subtle 15-degree gradient sweep

```css
/* Section divider example */
.section-divider {
  clip-path: polygon(0 0, 100% 0, 100% calc(100% - 3rem), 0 100%);
}

/* Angled rain texture */
.texture-rain {
  background-image: repeating-linear-gradient(
    105deg,           /* 90 + 15 = perpendicular to brand angle */
    transparent,
    transparent 8px,
    rgba(255, 255, 255, 0.03) 8px,
    rgba(255, 255, 255, 0.03) 9px
  );
}
```

## Section Spacing Rhythm

```
Hero section:       padding-block: space-24 (96px)
Primary sections:   padding-block: space-16 (64px)
Subsections:        padding-block: space-12 (48px)
Content blocks:     margin-bottom: space-8 (32px)
Paragraphs:         margin-bottom: space-4 (16px)
```
