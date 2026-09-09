# Namer App ( Rebuilt )

A redesigned and production-polished version of the official [Flutter Codelab Namer App](https://docs.flutter.dev/get-started/codelab).

This branch (`my_namer_app`) is my personal rebuild — same core functionality, completely overhauled design, architecture, and build configuration.

The original tutorial version lives on the `main` branch if you want to compare directly.

---

## What Changed

**Design**
- Custom color palette and typography replacing all default Flutter theming
- Micro-interactions: animated heart button, double-tap to like, smooth transitions
- Word history stream — tap any previous word to restore it
- Typographic watermark that cross-fades with the word history

**Architecture**
- Refactored from a single monolithic file into a clean modular structure (`/theme`, `/state`, `/widgets`, `/screens`)

**Build**
- R8 minification and resource shrinking enabled
- ABI splitting applied — reduced APK size significantly

---

## Download & Install (Android)

1. Go to the [Releases](https://github.com/Usmalik37/namer-app/releases) section
2. Download `namer-arm64-v8a.apk` (recommended — works on 99% of modern Android phones)
3. If that doesn't work on your device, download `namer-universal.apk` instead
4. Enable "Install from unknown sources" on your phone if prompted
5. Open the downloaded file and install

---

## Run Locally

```bash
git clone https://github.com/Usmalik37/namer-app.git
cd namer-app
git checkout my_namer_app
flutter pub get
flutter run
```

---

## Branches

| Branch | What it is |
|---|---|
| `main` | Original Flutter Codelab tutorial code |
| `my_namer_app` | Rebuilt, production-polished version |

---

*Built by Usmalik David Alexander · Malix Craft*