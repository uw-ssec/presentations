# SSEC Page Structure & Information Architecture

## Site Map

```
uw-ssec.github.io/
├── /                      → Home (hero + overview)
├── /projects/             → Project gallery (filterable)
│   └── /projects/:slug/   → Individual project detail
├── /about/                → Team, mission, origin story
├── /products/             → Software, publications, workshops
├── /ai-hub/               → AI initiatives, events, models, tutorials
├── /news/                 → News and events feed
└── /get-involved/         → Contact, collaboration CTA
```

## Page Templates

### 1. Home Page

```
┌──────────────────────────────────────────────────────────┐
│  NAV BAR (sticky, dark purple)                           │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  HERO SECTION (dark: purple-950)                         │
│  ┌────────────────────────┬─────────────────────────┐    │
│  │  Headline:             │  Abstract visualization  │    │
│  │  "Engineering the      │  (node network / data   │    │
│  │   Software Behind      │   stream animation)     │    │
│  │   Scientific Discovery"│                         │    │
│  │                        │                         │    │
│  │  Subhead + CTA buttons │                         │    │
│  └────────────────────────┴─────────────────────────┘    │
│                                                          │
│  ─── 15° angled divider ──────────────────────────────   │
│                                                          │
│  STATS BAR (gold-50 bg)                                  │
│  [ 22 Projects ] [ 11+ Software ] [ 10 Papers ] [ 20+ ] │
│                                                          │
│  ─────────────────────────────────────────────────────   │
│                                                          │
│  FEATURED PROJECTS (white bg, 3-column cards)            │
│  ┌──────┐ ┌──────┐ ┌──────┐                             │
│  │Proj 1│ │Proj 2│ │Proj 3│  → "View All Projects"      │
│  └──────┘ └──────┘ └──────┘                              │
│                                                          │
│  ─── 15° angled divider ──────────────────────────────   │
│                                                          │
│  AI THOUGHT LEADERSHIP (dark section, purple-950)        │
│  ┌────────────────────────┬─────────────────────────┐    │
│  │  "Advancing AI for     │  Teal-accented code      │    │
│  │   Scientific Research" │  block showing RAG/LLM   │    │
│  │  RAG Office Hours,     │  workflow or model card   │    │
│  │  LLMoxie, Events       │                          │    │
│  └────────────────────────┴─────────────────────────┘    │
│                                                          │
│  ─────────────────────────────────────────────────────   │
│                                                          │
│  TESTIMONIALS (warm: gold-50 bg, cards)                  │
│  ┌───────────────┐ ┌───────────────┐ ┌──────────────┐   │
│  │ Quote, name,  │ │ Quote, name,  │ │ Quote, name, │   │
│  │ affiliation   │ │ affiliation   │ │ affiliation  │   │
│  └───────────────┘ └───────────────┘ └──────────────┘   │
│                                                          │
│  ─────────────────────────────────────────────────────   │
│                                                          │
│  NEWS (white bg, latest 3 items)                         │
│                                                          │
│  SPONSORS (light section)                                │
│  "Made possible by Schmidt Sciences"                     │
│                                                          │
├──────────────────────────────────────────────────────────┤
│  FOOTER (purple-900)                                     │
│  UW Block W logo + SSEC text                             │
│  Site links │ GitHub │ Contact │ eScience link           │
│  UW required links (Accessibility, Privacy, Terms)       │
│  © University of Washington                              │
└──────────────────────────────────────────────────────────┘
```

### 2. Projects Page

```
┌──────────────────────────────────────────────────────────┐
│  Page Header: "Our Projects" (purple-700 bg, angled)     │
│  Intro paragraph                                         │
├──────────────────────────────────────────────────────────┤
│  FILTERS                                                 │
│  [Year ▼] [Discipline ▼] [Search... 🔍]                 │
├──────────────────────────────────────────────────────────┤
│  PROJECT GRID (3 columns, card-outlined variant)         │
│  ┌──────┐ ┌──────┐ ┌──────┐                             │
│  │      │ │      │ │      │                              │
│  ├──────┤ ├──────┤ ├──────┤                              │
│  │      │ │      │ │      │                              │
│  └──────┘ └──────┘ └──────┘                              │
│  ... (22 projects)                                       │
└──────────────────────────────────────────────────────────┘
```

### 3. AI Hub Page

```
┌──────────────────────────────────────────────────────────┐
│  Hero: "AI Hub" with neural network viz (dark, teal)     │
├──────────────────────────────────────────────────────────┤
│  Events (card-dark with teal accents)                    │
│  NAIRR Award (card with badge)                           │
│  RAG Office Hours (CTA card)                             │
│  Projects (AutoDoc, LLMoxie)                             │
│  Models (Hugging Face links with download stats)         │
│  Tutorials & Workshops                                   │
└──────────────────────────────────────────────────────────┘
```

## Content Sections — Visual Rhythm

The home page alternates between light and dark sections to create visual rhythm:

```
1. NAV         → dark (purple-900)
2. HERO        → dark (purple-950) with AI animation
3. STATS       → warm (gold-50)
4. PROJECTS    → light (white)
5. AI SECTION  → dark (purple-950) with teal accents
6. TESTIMONIALS→ warm (gold-50)
7. NEWS        → light (white)
8. SPONSORS    → light (neutral-50)
9. FOOTER      → dark (purple-900)
```

This light-dark-light-dark rhythm creates natural section boundaries without heavy dividers, while the 15-degree angled transitions between dark and light sections add the UW brand signature.
