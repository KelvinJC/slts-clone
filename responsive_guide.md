# Responsive Design Guide (Option 1)

This guide explains how to add **responsive sizing utilities** using `MediaQuery` and **BuildContext extensions**. Your screens can then use percentage‑based widths/heights without extra packages.

---

## 1. Create the Extension

1. **Create** a file at:
   ```
   lib/ui/utils/responsive.dart
   ```

2. **Add** this code:
   ```dart
   import 'package:flutter/widgets.dart';

   /// BuildContext extension for responsive sizing.
   extension Responsive on BuildContext {
     /// Full screen size.
     Size get screenSize => MediaQuery.of(this).size;

     /// Screen width in pixels.
     double get screenWidth => screenSize.width;

     /// Screen height in pixels.
     double get screenHeight => screenSize.height;

     /// Width as percentage of screen (e.g. 5.wp = 5% width).
     double wp(double percent) => screenWidth * percent / 100;

     /// Height as percentage of screen (e.g. 10.hp = 10% height).
     double hp(double percent) => screenHeight * percent / 100;
   }
   ```

---

## 2. No Initialization Needed

You do **not** need to wrap your app or call any initialization. As long as you have a valid `BuildContext`, you can call these methods.

---

## 3. Usage Examples

### Import the extension
```dart
import 'package:flutter/material.dart';
import 'package:your_app/ui/utils/responsive.dart';
```

### Example: Responsive Container
```dart
class ExampleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.hp(12),            // 12% of screen height
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: context.hp(2),         // 2% of screen height
        horizontal: context.wp(5),       // 5% of screen width
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(context.wp(2)), // 2% width radius
      ),
      child: Center(
        child: Text(
          'Responsive Box',
          style: TextStyle(fontSize: context.wp(4)),       // 4% width for font
        ),
      ),
    );
  }
}
```

### Example: Responsive Text
```dart
Text(
  'Welcome, Enforcer!',
  style: TextStyle(
    fontSize: context.hp(3),  // 3% of screen height
    fontWeight: FontWeight.bold,
  ),
);
```

---

## 4. Best Practices

- **Widths & horizontal spacing** → use `.wp(x)`  
- **Heights & vertical spacing** → use `.hp(x)`  
- Combine with your **`ui/themes`** for colors & text styles.  
- Combine with **`ui/widgets`** for buttons, inputs, and loaders.  
- No extra dependencies—just Flutter’s built‑in `MediaQuery`.

Happy coding, and may your UI always fit perfectly!
