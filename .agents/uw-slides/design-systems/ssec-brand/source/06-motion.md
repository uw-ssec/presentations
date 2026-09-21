# SSEC Motion Design

## Principles

1. **Purposeful** — every animation communicates state, relationship, or hierarchy
2. **Subtle** — motion supports content, never distracts from it
3. **Respectful** — honors `prefers-reduced-motion` system setting

## Duration Scale

| Token            | Value | Use Case                                    |
|------------------|-------|---------------------------------------------|
| `duration-fast`  | 100ms | Micro-interactions (checkbox, toggle)       |
| `duration-normal`| 200ms | Button hovers, input focus, card hover      |
| `duration-slow`  | 300ms | Page transitions, section reveals           |
| `duration-slower`| 500ms | Hero animations, complex transitions        |

## Easing

| Token         | Value                        | Use Case                       |
|---------------|------------------------------|--------------------------------|
| `ease-default`| cubic-bezier(0.4, 0, 0.2, 1) | General transitions            |
| `ease-in`     | cubic-bezier(0.4, 0, 1, 1)   | Elements exiting view          |
| `ease-out`    | cubic-bezier(0, 0, 0.2, 1)   | Elements entering view         |
| `ease-in-out` | cubic-bezier(0.4, 0, 0.2, 1) | Elements moving within view    |

## Signature Animations

### Scroll Reveal

Content sections fade in and translate up on scroll entry:

```css
.reveal {
  opacity: 0;
  transform: translateY(1.5rem);
  transition: opacity var(--duration-slow) var(--ease-out),
              transform var(--duration-slow) var(--ease-out);
}

.reveal.is-visible {
  opacity: 1;
  transform: translateY(0);
}
```

### Data Stream (AI identity)

Subtle background animation suggesting flowing data, used sparingly on hero sections:

```css
@keyframes data-stream {
  0% { background-position: 0% 0%; }
  100% { background-position: 100% 100%; }
}

.hero-bg-stream {
  background-image:
    repeating-linear-gradient(
      105deg,
      transparent,
      transparent 80px,
      rgba(42, 210, 201, 0.03) 80px,
      rgba(42, 210, 201, 0.03) 81px
    );
  background-size: 200% 200%;
  animation: data-stream 30s linear infinite;
}
```

### Node Pulse (AI network visualization)

Subtle pulsing nodes suggesting a neural network, used in the hero background:

```css
@keyframes node-pulse {
  0%, 100% { opacity: 0.15; transform: scale(1); }
  50% { opacity: 0.3; transform: scale(1.1); }
}

.node {
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: var(--color-teal-500);
  animation: node-pulse 4s var(--ease-in-out) infinite;
}
```

### Card Hover

```css
.card {
  transition: transform var(--duration-normal) var(--ease-default),
              box-shadow var(--duration-normal) var(--ease-default);
}

.card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}
```

## Reduced Motion

All animations are disabled for users who prefer reduced motion:

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }

  .reveal {
    opacity: 1;
    transform: none;
  }
}
```
