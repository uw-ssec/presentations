# Antenna Diagram Integration Notes

Created for `UWS-124` as reusable SVG assets for the Antenna SciPy presentation and A0 poster.

## Asset Path

Use the SVGs from `antenna/assets/diagrams/`:

- `antenna-a-push-model-before.svg` — place with the architecture problem statement for the original push flow.
- `antenna-b-pull-model-after.svg` — place immediately after A to explain the pull-based target architecture and horizontal scaling.
- `antenna-c-gpu-utilization-before.svg` — place before GPU optimization details to make idle time concrete.
- `antenna-d-cpu-gpu-data-flow.svg` — place where the PIL/CPU materialization bottleneck is introduced.
- `antenna-e-cuda-stream-pipeline.svg` — place with CUDA stream/overlap explanation.
- `antenna-f-gpu-utilization-after.svg` — place after E as the visual mirror of C and the payoff slide.

## Design Notes

- SVGs use `viewBox="0 0 1600 900"` for 16:9 slides and scalable poster placement.
- Primary diagram color is the requested deep blue `#1A5276`; accents are UW SSEC-compatible gold `#85754d`/`#b7a57a` and teal `#2ad2c9`.
- Typography follows UW SSEC presentation conventions: Encode Sans for headings/UI labels and Open Sans for supporting text, with system fallbacks.
- Each SVG includes `title`, `desc`, and `role="img"` for accessible embedding.

## Implementation Guidance

For Reveal.js slides, prefer direct image embedding at full content width:

```html
<img src="antenna/assets/diagrams/antenna-a-push-model-before.svg" alt="Antenna push model before optimization" class="diagram-full">
```

Suggested CSS:

```css
.diagram-full {
  display: block;
  inline-size: 100%;
  max-block-size: 72vh;
  object-fit: contain;
}
```

No content placeholders remain in the SVGs. The only dependency is deck-owner confirmation that `antenna/assets/diagrams/` is the final path for the Antenna deck.
