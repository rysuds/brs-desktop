---
name: app-zip
description: Package BrightScript apps as zip files compatible with the BrightScript Simulator. Ensures correct compression method (STORE) so the brs-engine's fflate library can read the archive. Use when creating, packaging, or zipping a Roku app, channel, or BrightScript project for the simulator.
---

# App Zip Packaging

## Why This Matters

The BrightScript Simulator uses `fflate` to read zip archives. fflate only supports **STORE (0)** and **DEFLATE (8)** compression methods. The default `zip` command on macOS may use unsupported methods, causing `unknown compression type` errors at load time.

## Packaging a Roku App

Run the packaging script:

```bash
bash .cursor/skills/app-zip/scripts/package-app.sh <app-directory> [output.zip]
```

### Parameters

| Arg | Required | Default | Description |
|-----|----------|---------|-------------|
| `<app-directory>` | Yes | -- | Directory containing `manifest` and `source/` |
| `[output.zip]` | No | `<app-directory>.zip` | Output zip file path |

### Example

```bash
bash .cursor/skills/app-zip/scripts/package-app.sh apps/snake-game apps/snake-game.zip
```

## Manual Zip Command

If not using the script, always use these flags:

```bash
zip -0 -X -r output.zip manifest source/ images/ fonts/ components/
```

| Flag | Purpose |
|------|---------|
| `-0` | STORE compression (method 0) -- no compression, fully compatible |
| `-X` | Exclude macOS extended attributes and resource forks |
| `-r` | Recurse into directories |

**Never use** plain `zip -r` without `-0 -X` -- it may produce archives the simulator cannot read.

## Verification

After packaging, verify compression methods are compatible:

```bash
python3 -c "
import zipfile
with zipfile.ZipFile('output.zip') as z:
    for i in z.infolist():
        assert i.compress_type in (0, 8), f'{i.filename}: bad type {i.compress_type}'
        print(f'{i.filename}: type={i.compress_type} ok')
print('All entries compatible')
"
```

## Required Zip Structure

The zip must be flat (manifest at root, not nested in a subfolder):

```
output.zip
├── manifest              # Required
├── source/
│   └── main.brs          # Required entry point
├── components/           # Optional (SceneGraph XML)
├── images/               # Optional
└── fonts/                # Optional
```
