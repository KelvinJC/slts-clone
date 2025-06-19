# Front‑end Screen Developer Guide

This document shows you **exactly** where and how to add screens and reusable UI components, without touching core/domain/data layers.

---

## 1. Folder Structure

```
lib/
├── core/                  ← foundation (leave this)
│
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── screens/      ← **YOUR FOCUS**: add new screen files here
│   │       └── widgets/      ← small, screen‑specific widgets
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/      ← secondary screens go here
│   │       └── widgets/
│   └── ...                  ← other features
│
├── ui/
│   ├── widgets/            ← global reusable widgets (buttons, inputs)
│   ├── themes/             ← color & text style definitions
│   └── routes.dart         ← register your screens here
│
├── assets/                 ← images, fonts
└── main.dart               ← app entry (leave this)
```

---

## 2. Adding a New Screen

1. **Create** `lib/features/<feature>/presentation/screens/<feature>_<screen>_screen.dart`  
2. **Import** only:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart'; // if you need providers
   ```
3. **Define**:
   ```dart
   class FeatureScreenName extends ConsumerWidget {
     const FeatureScreenName({Key? key}) : super(key: key);

     @override
     Widget build(BuildContext context, WidgetRef ref) {
       return Scaffold(
         appBar: AppBar(title: const Text('Title')),
         body: Center(child: Text('Your UI here')),
       );
     }
   }
   ```
4. **Use** global widgets from `ui/widgets/` (e.g. `PrimaryButton`, `LoadingOverlay`).

---

## 3. Reusable Widgets

- **Location**: `lib/ui/widgets/`
- **Purpose**: Buttons, text fields, loaders, cards.
- **Naming**: `<purpose>_widget.dart` or `<component_name>.dart`.
- **Example**:
  ```dart
  class PrimaryButton extends StatelessWidget { … }
  ```

---

## 4. Theming

- **Colors**: `lib/ui/themes/app_colors.dart`  
- **Text Styles**: `lib/ui/themes/app_text_theme.dart`  
- **Usage**:
  ```dart
  final color = Theme.of(context).colorScheme.primary;
  final style = Theme.of(context).textTheme.headline6;
  ```

---

## 5. Navigation / Routes

1. Open `lib/ui/routes.dart`.  
2. Add your route:
   ```dart
   '/your_route': (_) => const FeatureScreenName(),
   ```
3. Use:
   ```dart
   Navigator.pushNamed(context, '/your_route');
   ```

---

## 6. Code and Style

- **Linting**: run `dart analyze` & `flutter format .` before PR.  
- **Imports**: absolute paths only (no `../../../` beyond two levels).  
- **No business logic**: UI code only—state via providers in `features/<feature>/presentation/providers`.

---

## 7. Assets

- **Images**: put in `assets/images/` and register in `pubspec.yaml`.  
- **Fonts**: put in `assets/fonts/` and register.

---

### Quick Start Checklist

- [ ] Create screen file under `features/.../screens/`  
- [ ] Use `Scaffold`, `AppBar`, `body`  
- [ ] Pull styles from `ui/themes/`  
- [ ] Use components from `ui/widgets/`  
- [ ] Register route in `ui/routes.dart`  
- [ ] Lint & format  

Welcome aboard—happy coding!
