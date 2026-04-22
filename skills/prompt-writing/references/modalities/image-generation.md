# Image Generation Prompts

Load this file when the prompt is for generating or editing an image.

Image prompting is closer to art direction than form filling. Start by deciding what kind of visual work the model is being asked to do, then give it the right visual levers and invariants for that mode.

## 1. Choose the visual mode

Different image jobs need different prompt shapes.

- Photorealistic scene: write like a photographer. Use camera angle, lens feel, lighting, texture, imperfections, and what should make the image feel captured rather than staged.
- Creative or ad concept: write like a creative brief. Name brand, audience, cultural signal, concept, composition, mood, and exact copy, then leave room for taste within those boundaries.
- Product or merch mockup: write like a production preview. Emphasize material, packaging, print clarity, scale, silhouette, label integrity, and presentation.
- Structured visual: write like an artifact spec. For slides, infographics, diagrams, charts, and UI mockups, name the canvas, hierarchy, real text or data, readability bar, and visual language.
- Narrative sequence: write in visual beats. For comics, storyboards, or multi-panel images, make each panel or scene action-focused and easy to read.
- Surgical edit: write like a preservation contract. Say exactly what changes and what must remain unchanged.
- Style transfer or reference use: separate the fixed style cues from the new content. Name palette, texture, brushwork, film grain, typography, layout, or other traits that should carry over.
- Compositing or identity-sensitive edit: name the source element, target scene, placement, scale, shadows, perspective, lighting, and identity traits to preserve.

The prompt should make the mode obvious. "Make a poster" and "make a polished campaign poster for streetwear buyers" ask for different kinds of judgment.

## 2. Use visual levers deliberately

Reach for these when they change the image:

- deliverable and intended use
- audience or viewing context
- subject, scene, and action
- composition, framing, crop, and visual hierarchy
- lighting direction, quality, time of day, and atmosphere
- material, texture, surface detail, and imperfections
- typography, layout, copy, and legibility
- realism versus stylization
- polish level: draft, concept, production, premium, documentary, playful, technical
- invariants: what must stay exact across edits or iterations

Do not pile on every lever. Pick the few that make the image easier to judge.

## 3. Preserve the right degrees of freedom

Strong image prompts are not always more detailed. They are clear about where the model should be creative and where it should not drift.

- Lock exact text, labels, geometry, identity, brand constraints, reference roles, and production constraints.
- Leave room for the model to solve composition, secondary detail, and style when those are not the point.
- For exploratory work, ask for a mode and taste direction rather than a fully specified layout.
- For production work, tighten the output bar and invariants.

## 4. Repair by changing the visual strategy

When the output misses, do not only add adjectives. Change the prompt's visual strategy.

- Too generic: add audience, use case, cultural context, or the kind of artifact it should resemble.
- Too staged or artificial: use natural-photo cues such as ordinary lighting, real texture, candid framing, and believable imperfections.
- Composition is muddy: specify the focal point, crop, hierarchy, spacing, or number of panels.
- Text is wrong or weak: quote the exact text, say where it appears, specify typography and contrast, and forbid extra text.
- Edit drifts: restate what must remain unchanged and narrow the change to one target.
- Style transfer misses: name the reference traits to preserve, not just "use this style."
- Composite looks pasted on: specify matching light, shadows, perspective, scale, and contact with the scene.
- Product asset feels restyled: ask for light polishing only, preserve geometry and label legibility, and avoid redesign language.

## 5. Know when the prompt is not the only lever

The cookbook examples use small iterative changes instead of one giant prompt. If the image is close, adjust the one visual variable that is wrong and restate the invariants.

Prompt text is not always the fix:

- If latency, resolution, or fidelity is the issue, check image model settings before adding more prose.
- If a reference edit loses identity or precise visual traits, preserve those traits explicitly and use the appropriate input-fidelity setting when the runtime supports it.
- If transparent output is unreliable for a production asset, ask for a clean opaque background and handle background removal downstream.
- If repeated generations miss the same subjective taste bar, gather a small set of accepted and rejected examples instead of expanding the prompt endlessly.

## 6. Compact examples

### Creative brief

```text
Create a polished campaign poster for a young streetwear brand.
Audience: style-conscious city shoppers.
Concept: friends gathered after a late-night pop-up, energetic but tasteful.
Use premium fashion photography cues, natural poses, strong color direction, and clean composition.
Include the tagline exactly once, clearly and legibly: "Yours to Create."
No extra text, unrelated logos, or watermarks.
```

### Artifact spec

```text
Create one landscape pitch-deck slide titled "Market Opportunity."
Use a clean white background, crisp startup-deck typography, and a clear data hierarchy.
Include a TAM/SAM/SOM diagram, a simple growth chart, and the provided numbers and labels exactly.
Make text readable at deck scale.
Avoid stock imagery, decorative clutter, gradients, and overdesigned effects.
```

### Natural photorealism

```text
Create a candid photorealistic image that feels captured in a real moment.
Use eye-level framing, natural daylight, real skin and fabric texture, and small imperfections.
Avoid cinematic color grading, glamour lighting, heavy retouching, and posed studio polish.
```

### Surgical edit

```text
Starting from the input image, replace only the chairs with wood chairs.
Preserve camera angle, room lighting, floor shadows, surrounding objects, and overall composition.
Keep all other aspects unchanged.
Make the new chairs look physically present, with realistic contact shadows and matching perspective.
```

### Reference compositing

```text
Place the object from image 2 into the scene from image 1.
Put it next to the main subject, matched to the scene's lighting, perspective, scale, and shadows.
Do not change the background, camera angle, framing, or existing subject.
```

### Production-constrained asset

```text
Create an engraving-ready monochrome depth-map style image.
Preserve crisp block text.
Use deep blacks and strong highlights.
Do not add extra text, decoration, or watermark.
```
