# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

BrightScript Simulator (`brs-desktop`) — an Electron desktop app that simulates a Roku device for BrightScript development. See `README.md` and `.github/copilot-instructions.md` for architecture details.

### Running the application

- **Dev mode:** `npm run start` (runs Webpack in watch mode + launches Electron). See `docs/build-from-source.md`.
- **Build only:** `npm run build` (Webpack bundles `src/` into `app/`).
- **Direct Electron launch (pre-built):** `npx electron .` (requires `app/` to exist from a prior build).
- **Load a `.brs` file on startup:** `DISPLAY=:99 npx electron . /path/to/file.brs`
- Electron requires a display. On headless Linux, start Xvfb first: `Xvfb :99 -screen 0 1920x1080x24 -ac &` and set `DISPLAY=:99`.
- On first launch a "BrightScript and SceneGraph Support" warning dialog appears; dismiss it with Enter.

### Lint / test

This project has **no linter or automated test suite** configured. There are no `eslint`, `prettier`, `jest`, or `mocha` configs, and no `lint`/`test` npm scripts.

### Caveats

- The `app/` directory (Webpack output) is gitignored. You must run `npm run build` (or `npm run start`, which builds automatically) before launching Electron directly.
- `npm install` runs `electron-builder install-app-deps` as a postinstall step; this rebuilds native modules for the current Electron version.
- The Code Editor (F12 or View menu) can load and run standalone `.brs` files. BrightScript code that uses `roFont` will crash — use only basic Draw2D primitives (`DrawRect`, `Clear`, `SwapBuffers`) for reliable rendering.
- The brs-app-generator skill (`.cursor/skills/brs-app-generator/SKILL.md`) can scaffold sample `.brs` apps; its templates may use `roFont` — edit out font usage if the simulator crashes.
- DBus errors in the console (e.g. "Failed to connect to the bus") are harmless on headless Linux and do not affect functionality.
