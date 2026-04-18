---
name: xtool-studio
description: Operate xTool Studio through [@computer-use](plugin://computer-use@local) to import local artwork, measure a real material surface, size the design from that measurement, place it from measured anchors, and verify the final footprint stays on the physical material. Use when Codex needs to set up or correct geometry in xTool Studio for engraving or cutting jobs, especially after a new import, when camera views can be misleading, or when the user expects placement based on measured stock rather than visual guesswork.
---

# xTool Studio

## Overview

Use this skill to replace visual guesswork with measured geometry. Treat imported artwork, machine presets, and camera framing as provisional until measurement-based sizing and placement are complete.

## Terms

- Treat the `eligible surface` as the physical material only. Exclude the camera field, machine opening, bed, slats, artboard, and canvas.
- Treat the `design footprint` as the full processed area. For bitmaps, use the full bitmap bounds, not only the visible subject.
- Treat the `usable span` as the measured dimension of the eligible surface available to the design.
- Treat `placement anchors` as the measured material points whose `x` and `y` values define where the design may sit.
- Treat the `target size` as the final `W` or `H` the design should use.
- Treat the `requested target surface` as the specific physical surface the user means, not just any visible material that could fit the design.
- Lock one exact name for the eligible surface after identifying it, then keep using that same name.

## Default Rule

- Require both of these before calling a new import done:
  - Keep the full design footprint on the eligible surface.
  - Derive the final size and final position from either user-provided geometry or the `Measurement` tool.
- Require specific target-surface certainty before geometry work:
  - If the user refers to one of multiple surfaces by role, position, or order, identify that exact physical surface first.
  - Do not substitute a different visible surface just because it is measurable or currently centered in view.
- Finish geometry before recipe edits unless the user explicitly asks for a different order.
- Treat `Scale to fit`, auto-import sizing, and "it fits on the board" as temporary states, not proof.
- Skip `Measurement` only if the user explicitly gives the final size and position, or explicitly asks to preserve the current geometry.
- Treat a new import without measurement-based sizing or placement as incomplete unless the user supplied the missing geometry.
- Treat numeric `X`, `Y`, `W`, and `H` fields as execution tools, not proof. Their correctness must trace back to the requested target surface plus fresh verification.

## Workflow

1. Orient

- Activate `xTool Studio`.
- Use `Cmd-0` to fit the canvas.
- Refresh the camera background before judging placement if it may be stale.

2. Select target and surface

- Import local files with `Cmd-I` or the left sidebar `Import` item.
- Do not use cloud upload actions when the task is local import.
- Confirm the intended object is selected before editing settings or geometry.
- Identify and briefly name the eligible surface from the camera view.
- If the user specified a particular surface among multiple candidates, first confirm that the currently visible surface is that requested target surface.
- If the requested target surface is not distinguishable in the current view, stop geometry work and refresh, expand, or otherwise recover a view where it is.
- Do not continue to `Measurement`, numeric geometry edits, or recipe setup while target-surface identity is ambiguous.
- Use the top-right `Material` section only as a cue to help find that same surface.

3. Measure

- For a new import without complete final geometry from the user, open left sidebar `Applications` and launch `Measurement` before final sizing or placement.
- If `Smart nesting` or another app opens, close it and open `Measurement` again.
- Measure the actual material, not the bitmap, machine opening, bed, or preset.
- Use the two clicked `(x, y)` points directly.
- For rectangular stock, prefer one measurement between opposite corners of the usable area.
- Derive width, height, center, and placement bounds from those two corner coordinates. Do not separately re-measure width and height unless that corner measurement failed.
- Treat the measurement as valid even if the drawn line visually crosses the bitmap, empty space, or other content.
- For irregular material, capture the specific boundary points that define the intended placement area and derive the limiting span from those points.
- Treat import-time sizing as a temporary starting point only.

4. Size from measurement

- Use the user's exact size if they provided one.
- Otherwise choose a `target size` slightly under the measured usable span so a visible safety margin remains.
- For rectangular stock, compute the usable span from the difference between the measured corner coordinates.
- Prefer numeric `W` or `H` entry over repeated drag guessing.
- Preserve aspect ratio unless the user asked otherwise.
- Treat size and position as separate problems. Numeric size sets scale; measured anchors set location.

5. Place from measured anchors

- Use the same measured points to decide where the design belongs. Do not place by eye against the broader camera view.
- Do not switch back to freehand centering after measuring.
- Prefer numeric object `X` and `Y` when available.
- If numeric entry is not practical, use a controlled drag or nudges while comparing against the measured anchors.
- Do not treat one freehand drag as final placement.
- If centered placement is desired, derive it from the measured material limits, not from the machine opening or visible canvas.

6. Verify

- Treat any import, move, resize, or numeric geometry edit as invalidating previous proof.
- Take a dedicated fresh `get_state` after the last geometry change.
- On that fresh view, confirm that the requested target surface is still the same surface identified earlier.
- Check the final placement against the measured anchors and the fresh camera view.
- Compare the full design footprint to the same eligible surface identified earlier.
- Verify the user's requested region or object, not merely that the design is on some valid material.
- Verify both placement and sizing. A design can be fully on the material and still be the wrong size.
- If any part of the footprint sits on bed, slats, machine opening, empty background, or any non-material surface, treat placement as failed.
- If the size is right but one edge is still off, translate inward. Do not keep shrinking blindly.
- If the design is fully on the material but obviously smaller than the measurement-based target, return to sizing instead of declaring success.
- Treat a successful `drag` or `set_value`, or its bundled screenshot, as insufficient proof by itself.
- Do not say `fits`, `done`, or `safe` until fresh verification passes.

7. Finish

- Preserve the user's requested recipe settings unless asked to change them.
- If settings change after placement, run one final placement check.
- Do not enter `Process`, `Start`, or machine handoff until both of these are proven on a fresh view:
  - target-surface identity
  - full-footprint containment on that exact surface
- Treat the task as incomplete until placement verification passes and the size requirement is satisfied.

## Fallback

- Use camera-only sizing only if `Measurement` cannot be opened after a reasonable retry, or the user explicitly does not want resizing.
- In fallback mode, verify containment if possible, but do not present the result as measurement-based sizing or measurement-based placement.
- If fallback mode still leaves the requested target surface ambiguous, report that ambiguity explicitly and do not claim safe placement.

## Language Discipline

- Report the action you are taking, not the success you expect.
- Prefer: `I measured the faux maple MDF board, set the image height from that span, and I’m placing it from the measured board coordinates before re-checking on a fresh view.`
- Prefer: `The size is right, but the top edge is still off the board, so I’m moving it down and checking again.`
- Avoid: `The image looks centered, so it fits.`
- Avoid: `I made it smaller, so it should be fine.`

## Goal

Leave xTool Studio with the selected design imported correctly, measurement-sized and measurement-positioned unless the user explicitly chose otherwise, and visibly contained on the physical material rather than the surrounding bed.
