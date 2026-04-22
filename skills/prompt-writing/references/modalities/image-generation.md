# Image Generation Prompts

Load this file when the prompt is for generating or editing an image.

Image prompts need different structure from ordinary text-agent prompts. The deliverable is visual, and small wording changes can alter composition, text rendering, or what survives an edit.

## 1. Questions to answer first

- Is this a new image or an edit?
- What is the artifact for: concept art, product shot, poster, UI mock, technical asset, engraving asset, and so on?
- What must be preserved?
- What is allowed to change?
- Are there reference images, and what does each one contribute?
- Is there exact text that must appear in the image?
- Are there production constraints such as transparent background, printability, legibility, or high-contrast output?

## 2. What to make explicit

For new generations, specify the parts that actually control the result:

- deliverable and intended use
- subject and scene
- composition, framing, or camera angle
- style, material, lighting, or overall look
- must-include elements
- must-avoid elements
- exact text to render, quoted verbatim

For edits, also specify:

- what to change
- what must stay unchanged
- whether the style, perspective, lighting, and composition should match the source

For reference-based prompts:

- say what each input image is for
- separate fixed reference traits from flexible creative choices

## 3. Durable rules

- Name the deliverable, not just the topic.
- Quote literal text that must appear in-image.
- If the asset has downstream production constraints, keep them verbatim.
- For edits, "change only X" and "keep everything else the same" are high-leverage instructions.
- If multiple references matter, say what each one contributes instead of vaguely saying "use these as inspiration."

## 4. New-image scaffold

```text
Create a [deliverable] for [intended use].

Subject and scene:

Composition and framing:

Style and look:

Must include:

Must avoid:

Text to render exactly:
"..."
```

## 5. Edit scaffold

```text
Starting from the input image, change only:

Keep unchanged:

Match the existing:
- style
- lighting
- perspective
- composition

Text that must remain or appear exactly:
"..."
```

## 6. Short examples

### Reference-based generation

```text
Create a photorealistic product gift basket image for an ecommerce listing on a white background.
Include all items from the reference images.
Label the basket exactly "Relax & Unwind" in a handwriting-like font tied with a ribbon.
Keep the composition clean and centered.
```

### Local edit with strong invariants

```text
Starting from the input image, change only the pool contents to a flamingo.
Keep the sunlit indoor lounge, camera angle, lighting, and overall composition unchanged.
```

### Production-constrained asset

```text
Create an engraving-ready monochrome depth-map style image.
Preserve crisp block text.
Use deep blacks and strong highlights.
Do not add extra text, decoration, or watermark.
```
