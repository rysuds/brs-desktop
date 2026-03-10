---
name: brs-app-generator
description: Generate BrightScript applications with visual output for the BrightScript Simulator. Creates ready-to-run .brs files from templates (dashboard, animation, game) that draw colorful graphics on the simulated TV screen. Use when the user wants to create, generate, or scaffold a BrightScript app, demo, or visual prototype.
---

# BrightScript App Generator

Generate ready-to-run BrightScript applications for the BrightScript Simulator desktop app. Each template produces visible graphics on the simulated TV display.

## Available Templates

| Template | What It Shows | Interactive? |
|----------|---------------|--------------|
| `dashboard` | Streaming TV interface: hero banner, content cards, navigation | No (static layout) |
| `animation` | Colorful bouncing shapes across the screen | Animated, press Back to exit |
| `game` | Paddle-and-ball arcade game with score | Arrow keys to play, OK to restart |

## Usage

Run the generator script:

```bash
bash .cursor/skills/brs-app-generator/scripts/generate-app.sh \
  --template <dashboard|animation|game> \
  --title "Your App Title" \
  --output path/to/output.brs
```

### Parameters

| Flag | Required | Default | Description |
|------|----------|---------|-------------|
| `--template` | Yes | -- | `dashboard`, `animation`, or `game` |
| `--title` | No | "My BrightScript App" | Title displayed in the app header |
| `--output` | No | `<template>_app.brs` | Output file path |

## Running the Generated App

After generating the `.brs` file:

1. The simulator should already be running (`npm run start` from the project root)
2. In the simulator window, go to **View -> Code Editor**
3. Select all text in the editor, then paste the generated code
4. Click the **Run** button (triangle icon)

The app renders immediately on the simulated TV display.

## Keyboard Controls (in the simulator)

| Key | Action |
|-----|--------|
| Arrow keys | Navigate / move paddle |
| Enter | OK / Select |
| Backspace | Back / exit app |

## Customizing Templates

Templates live in `assets/`. They use the BrightScript Draw 2D API:

- `DrawRect(x, y, width, height, color)` -- filled rectangle
- `DrawText(text, x, y, color, font)` -- text label
- `Clear(color)` -- fill screen with solid color
- `SwapBuffers()` -- push frame to display

Colors are 32-bit RGBA hex: `&hRRGGBBAA` (e.g. `&hFF0000FF` = red).

Screen resolution is 1280x720 (standard HD).
