# Mega TTT

A full-screen tic-tac-toe game built with **Flutter** and **Flame**.

## Features

- Two-player local tic-tac-toe on a full-screen grid
- Built with Flame 2D game engine
- Visual win detection with strike-through lines
- Reset button to start a new match
- Clean dark theme UI

## Getting Started

```bash
flutter pub get
flutter run
```

## Gameplay

- Players take turns tapping cells on the grid
- Player **X** is blue, Player **O** is red
- First to get 3 in a row wins
- If the board fills with no winner, it's a draw

## GitHub Release Build

To create a signed release with ABI-split APKs and an AAB:

### 1. Configure GitHub Secrets

| Secret | Description |
|--------|-------------|
| `KEYSTORE_BASE64` | Base64-encoded release keystore file |
| `KEYSTORE_PASSWORD` | Keystore password |
| `KEY_PASSWORD` | Key password |
| `KEY_ALIAS` | Key alias |

### 2. Run the release helper script

```bash
./scripts/tag-release.sh v1.0.0
```

This bumps the version in `pubspec.yaml` to `1.0.0+10000`, commits, pushes, creates an annotated tag, and triggers GitHub Actions.

### 3. Release artifacts

The workflow produces:
- `app-armeabi-v7a-release.apk`
- `app-arm64-v8a-release.apk`
- `app-x86_64-release.apk`
- `app-release.aab`

All artifacts are attached to the GitHub Release for the tag.

## License

GPL-3.0-only
