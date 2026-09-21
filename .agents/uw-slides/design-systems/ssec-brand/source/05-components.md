# SSEC Foundational Components

## 1. Button

### Variants

| Variant     | Background               | Text                | Border               | Use Case                        |
|-------------|--------------------------|---------------------|----------------------|---------------------------------|
| Primary     | `purple-700`             | `white`             | none                 | Primary CTAs, form submissions  |
| Secondary   | transparent              | `purple-700`        | 2px `purple-700`     | Secondary actions               |
| Ghost       | transparent              | `purple-700`        | none                 | Tertiary actions, nav links     |
| Inverse     | `white`                  | `purple-700`        | none                 | CTAs on dark/purple backgrounds |
| Accent      | `teal-500`               | `purple-950`        | none                 | AI-related CTAs (sparingly)     |
| Destructive | `color-error`            | `white`             | none                 | Delete, remove actions          |

### Sizes

| Size   | Padding              | Font Size  | Min Height |
|--------|----------------------|------------|------------|
| Small  | `space-1-5` `space-3`| `text-sm`  | 32px       |
| Medium | `space-2` `space-5`  | `text-sm`  | 40px       |
| Large  | `space-3` `space-6`  | `text-base`| 48px       |

### States

- **Default**: As specified per variant
- **Hover**: Darken background by one step (e.g., purple-700 -> purple-900)
- **Focus**: `focus-ring` (UW standard: 0.2rem shadow, purple 50% alpha)
- **Active**: Darken one more step, slight scale(0.98)
- **Disabled**: 50% opacity, cursor not-allowed
- **Loading**: Text replaced with spinner, maintains button width

### Specs

```css
.button {
  font-family: var(--font-compressed);
  font-weight: var(--font-semibold);
  letter-spacing: var(--tracking-wide);
  text-transform: uppercase;
  border-radius: var(--radius-none);  /* UW brand: sharp corners */
  transition: all var(--duration-normal) var(--ease-default);
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  text-decoration: none;
}

.button:focus-visible {
  outline: none;
  box-shadow: var(--focus-ring);
}
```

### Accessibility

- Minimum touch target: 44x44px
- All buttons must have accessible text (visible label or `aria-label`)
- Keyboard: Enter and Space activate the button
- Loading state announces via `aria-busy="true"`
- Disabled buttons use `aria-disabled="true"` (not `disabled` attribute on links)

---

## 2. Card

### Variants

| Variant     | Background            | Border                | Shadow        | Use Case                        |
|-------------|-----------------------|-----------------------|---------------|---------------------------------|
| Default     | `white`               | 1px `border-default`  | `shadow-sm`   | General content cards           |
| Elevated    | `white`               | none                  | `shadow-md`   | Featured items, hover state     |
| Outlined    | transparent           | 1px `border-strong`   | none          | Project listings, minimal style |
| Dark        | `purple-950`          | 1px rgba(255,255,255,0.1) | `shadow-glow-sm` | AI features, code-related  |
| Warm        | `gold-50`             | 1px `gold-200`        | none          | Testimonials, quotes            |

### Structure

```
┌─────────────────────────────────────┐
│  [Optional: Image / Media]          │  ← Full-width, aspect-ratio: 16/9
├─────────────────────────────────────┤
│  [Optional: Tag / Category]         │  ← text-xs, uppercase, teal-500 or purple
│  Heading                            │  ← text-lg or text-xl, semibold
│  Description text that provides     │  ← text-base, text-secondary
│  context and detail about the card. │
│                                     │
│  [Optional: Meta / Footer]          │  ← text-sm, text-tertiary
│  [Optional: Action / Link]          │  ← button or text link
└─────────────────────────────────────┘
```

### Specs

```css
.card {
  border-radius: var(--radius-md);
  padding: var(--space-6);
  transition: all var(--duration-normal) var(--ease-default);
  overflow: hidden;
}

.card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
}

.card__image {
  margin: calc(var(--space-6) * -1);
  margin-bottom: var(--space-6);
  aspect-ratio: 16 / 9;
  object-fit: cover;
  width: calc(100% + var(--space-6) * 2);
}

.card__tag {
  font-family: var(--font-compressed);
  font-size: var(--text-xs);
  font-weight: var(--font-semibold);
  letter-spacing: var(--tracking-widest);
  text-transform: uppercase;
  color: var(--text-brand);
  margin-bottom: var(--space-2);
}

.card__title {
  font-family: var(--font-display);
  font-size: var(--text-xl);
  font-weight: var(--font-semibold);
  color: var(--text-primary);
  margin-bottom: var(--space-2);
}

.card__body {
  font-family: var(--font-body);
  font-size: var(--text-base);
  color: var(--text-secondary);
  line-height: var(--leading-relaxed);
}
```

### Accessibility

- Cards that are entirely clickable use `<a>` wrapping with `aria-label` for full context
- Image cards must have descriptive `alt` text
- Focus state shows `focus-ring` around the card boundary
- Card hover effects respect `prefers-reduced-motion`

---

## 3. Input

### Variants

| Variant   | Use Case                            |
|-----------|-------------------------------------|
| Text      | Names, general text                 |
| Email     | Email addresses                     |
| Search    | Search bars with icon               |
| Textarea  | Multi-line text (comments, messages)|
| Select    | Dropdown selection                  |

### States

| State    | Border Color      | Background        | Additional                       |
|----------|-------------------|--------------------|----------------------------------|
| Default  | `border-default`  | `white`            |                                  |
| Hover    | `border-strong`   | `white`            |                                  |
| Focus    | `border-focus`    | `white`            | `focus-ring`                     |
| Error    | `color-error`     | `color-error-light`| Error message shown below        |
| Disabled | `border-default`  | `neutral-100`      | 50% opacity on content           |

### Structure

```
Label Text *                          ← text-sm, semibold, required indicator
┌─────────────────────────────────┐
│  Placeholder text...            │   ← text-base, neutral-400
└─────────────────────────────────┘
Helper text or error message          ← text-sm, secondary or error color
```

### Specs

```css
.input {
  font-family: var(--font-body);
  font-size: var(--text-base);
  line-height: var(--leading-normal);
  padding: var(--space-2-5) var(--space-3);
  border: 1px solid var(--border-default);
  border-radius: var(--radius-md);
  background: var(--color-white);
  color: var(--text-primary);
  width: 100%;
  transition: border-color var(--duration-fast) var(--ease-default),
              box-shadow var(--duration-fast) var(--ease-default);
}

.input:hover {
  border-color: var(--border-strong);
}

.input:focus {
  outline: none;
  border-color: var(--border-focus);
  box-shadow: var(--focus-ring);
}

.input--error {
  border-color: var(--color-error);
  background: var(--color-error-light);
}

.input__label {
  font-family: var(--font-body);
  font-size: var(--text-sm);
  font-weight: var(--font-semibold);
  color: var(--text-primary);
  margin-bottom: var(--space-1-5);
  display: block;
}

.input__helper {
  font-size: var(--text-sm);
  color: var(--text-secondary);
  margin-top: var(--space-1);
}

.input__error {
  font-size: var(--text-sm);
  color: var(--color-error);
  margin-top: var(--space-1);
}
```

### Accessibility

- Every input must have a visible `<label>` with matching `for`/`id`
- Required fields use `aria-required="true"` and visible `*` indicator
- Error messages linked via `aria-describedby`
- Error inputs use `aria-invalid="true"`
- Keyboard: Tab to navigate, Enter to submit
- Minimum input height: 44px for touch targets

---

## 4. Navigation Bar (SSEC-specific)

### Structure

```
┌──────────────────────────────────────────────────────────────────┐
│  [W Logo] SSEC          Projects  About  Products  AI Hub  [CTA]│
│                                                        GitHub →  │
└──────────────────────────────────────────────────────────────────┘
```

### Specs

```css
.nav {
  background: var(--surface-inverse);  /* purple-900 */
  padding: var(--space-4) var(--space-8);
  position: sticky;
  top: 0;
  z-index: var(--z-sticky);
  backdrop-filter: blur(8px);
}

.nav__logo {
  font-family: var(--font-compressed);
  font-weight: var(--font-bold);
  font-size: var(--text-lg);
  color: var(--color-white);
  letter-spacing: var(--tracking-wide);
  text-transform: uppercase;
}

.nav__links {
  font-family: var(--font-compressed);
  font-weight: var(--font-semibold);
  font-size: var(--text-sm);
  letter-spacing: var(--tracking-wider);
  text-transform: uppercase;
  color: var(--color-gold-200);
  gap: var(--space-6);
}

.nav__link:hover {
  color: var(--color-white);
}

.nav__link--active {
  color: var(--color-white);
  border-bottom: 2px solid var(--color-teal-500);
}
```

### Mobile: Hamburger menu collapses links into a full-screen overlay on `purple-950` background.

---

## 5. Section Divider (SSEC signature element)

The angled section transition using the UW 15-degree brand motif.

```css
.section-divider {
  position: relative;
}

.section-divider::after {
  content: "";
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 4rem;
  background: inherit;
  clip-path: polygon(0 0, 100% 60%, 100% 100%, 0 100%);
}
```

---

## 6. Code Block (AI/Tech identity element)

```css
.code-block {
  background: var(--surface-terminal);   /* purple-950 */
  border: 1px solid rgba(42, 210, 201, 0.15);
  border-radius: var(--radius-md);
  padding: var(--space-6);
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  color: var(--color-teal-500);          /* Teal text on dark purple */
  line-height: var(--leading-loose);
  overflow-x: auto;
  position: relative;
}

.code-block::before {
  content: "$ ";
  color: var(--color-gold-500);
  opacity: 0.6;
}

.code-block__header {
  font-family: var(--font-compressed);
  font-size: var(--text-xs);
  letter-spacing: var(--tracking-widest);
  text-transform: uppercase;
  color: var(--color-neutral-500);
  padding-bottom: var(--space-3);
  margin-bottom: var(--space-3);
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}
```

---

## 7. Stat Counter (Hero metrics)

For displaying impact numbers (e.g., "22 Projects", "10+ Publications").

```css
.stat {
  text-align: center;
}

.stat__number {
  font-family: var(--font-display);
  font-weight: var(--font-extrabold);
  font-size: var(--text-5xl);
  letter-spacing: var(--tracking-tighter);
  color: var(--text-brand);
  line-height: var(--leading-none);
}

.stat__label {
  font-family: var(--font-compressed);
  font-size: var(--text-sm);
  font-weight: var(--font-semibold);
  letter-spacing: var(--tracking-widest);
  text-transform: uppercase;
  color: var(--text-secondary);
  margin-top: var(--space-2);
}
```
