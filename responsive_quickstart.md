# Responsive Usage Quickstart

Here’s how to apply responsiveness in your screens:

---

## Import

At the top of your Dart file:
```dart
import 'package:flutter/material.dart';
import 'package:your_app/ui/utils/responsive.dart';
```

---

## Widgets

### Responsive Container Example
```dart
Container(
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
)
```

---

### Responsive Text Example
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

## Spacing & Sizing

- **Horizontal**: `context.wp(x)`  
- **Vertical**: `context.hp(x)`  
- **Font size**: use `wp` or `hp` depending on design, e.g. `fontSize: context.hp(2.5)`

---

## Example Full Screen

```dart
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: EdgeInsets.all(context.wp(4)),
        child: Column(
          children: [
            SizedBox(height: context.hp(2)),
            ElevatedButton(
              onPressed: () {},
              child: Text('Run Plate', style: TextStyle(fontSize: context.wp(4))),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, context.hp(6)),
              ),
            ),
            // ...other buttons...
          ],
        ),
      ),
    );
  }
}
```

---

Use these patterns across your screens for consistent, percentage-based responsiveness.
