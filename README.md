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

To create a signed release APK:

1. Ensure the following GitHub secrets are configured:
   - `KEYSTORE_BASE64`
   - `KEYSTORE_PASSWORD`
   - `KEY_PASSWORD`
   - `KEY_ALIAS`

2. Run the release helper script:

```bash
./scripts/tag-release.sh v1.0.0
```

This bumps the version, commits, pushes, creates a tag, and triggers GitHub Actions to build and publish the signed APK.
