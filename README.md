# Universal Flutter Tutorial & Onboarding Guide

A clean, plug-and-play guide to add feature tutorials and coach marks to any Flutter screen, static widget, list item, or dialog.

---

## 📂 Architecture Overview (`lib/core/tutorial/`)
The tutorial system consists of these core files:
- `tutorial_manager.dart`: Central manager to show, sequence, or reset tutorials.
- `tutorial_step.dart`: Model defining each step (`TutorialStep`).
- `tutorial_target_helper.dart`: Automatically scrolls targets into view and checks rendering readiness.
- `tutorial_storage.dart`: Persists completion status using `SharedPreferences`.

---

## 🟢 Option 1: Normal / Basic Tutorial (For Static Screens)
Use this when you only want to highlight buttons, app bars, or cards on a standard screen without any dynamic list items or popups.

### Step 1: Define Your Tutorial Steps
Create a tutorial file (e.g., `my_screen_tutorial.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../core/tutorial/tutorial_step.dart';

class MyScreenTutorial {
  static const id = 'my_screen_v1';

  // Define GlobalKeys for your UI elements
  static final buttonKey = GlobalKey();
  static final cardKey = GlobalKey();

  static List<TutorialStep> get steps => [
    TutorialStep(
      id: 'step_card',
      targetKey: cardKey,
      title: 'Welcome Card',
      description: 'This card displays your summary information.',
    ),
    TutorialStep(
      id: 'step_button',
      targetKey: buttonKey,
      title: 'Action Button',
      description: 'Tap here to add a new item.',
      shape: ShapeLightFocus.Circle,
    ),
  ];
}
```

### Step 2: Attach Keys to Widgets
```dart
// In your screen widget:
Card(
  key: MyScreenTutorial.cardKey,
  child: const Text('Hello World'),
)

FloatingActionButton(
  key: MyScreenTutorial.buttonKey,
  onPressed: () {},
  child: const Icon(Icons.add),
)
```

### Step 3: Trigger in `initState`
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    if (mounted) {
      await TutorialManager.instance.show(
        context: context,
        tutorialId: MyScreenTutorial.id,
        steps: MyScreenTutorial.steps,
        force: true, // Set to false in production to show only once
      );
    }
  });
}
```

---

## 🟡 Option 2: Advanced Tutorial (For List Items & Dialogs)

### A. How to Pass Tutorial Keys to List Items
Because list items are rendered dynamically in a list builder, target **only the first visible item** using a conditional index check.

**1. Define Action Keys in Tutorial Class:**
```dart
class ListActionKeys {
  final GlobalKey editKey = GlobalKey();
  final GlobalKey deleteKey = GlobalKey();
}

class AdvancedTutorial {
  static const id = 'advanced_list_v1';
  static final ListActionKeys actionKeys = ListActionKeys();

  static List<TutorialStep> get steps => [
    TutorialStep(
      id: 'list_edit',
      targetKey: actionKeys.editKey,
      title: 'Edit Item',
      description: 'Tap here to edit this list item.',
    ),
  ];
}
```

**2. Pass Keys Conditionally in ListView Builder:**
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    // Condition: Target ONLY the first item in the list
    final bool isTarget = index == 0 && items.isNotEmpty;

    return MyListItem(
      item: items[index],
      // Pass action keys only to the target row, otherwise pass null
      keys: isTarget ? AdvancedTutorial.actionKeys : null,
    );
  },
)
```

**3. Use Keys Inside the List Item Widget:**
```dart
class MyListItem extends StatelessWidget {
  final dynamic item;
  final ListActionKeys? keys;

  const MyListItem({super.key, required this.item, this.keys});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      trailing: IconButton(
        key: keys?.editKey, // Attached only if it's the target row
        icon: const Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }
}
```

---

### B. How to Handle Dialogs and Bottom Sheets
If your tutorial highlights widgets inside a popup dialog or bottom sheet, use `isTutorialTargetReady()` so the tutorial engine only runs when the dialog is fully rendered:

```dart
Future<void> showMyDialogTutorial(BuildContext dialogContext) async {
  final steps = MyScreenTutorial.steps
      .where((step) => isTutorialTargetReady(step.targetKey))
      .toList();

  if (steps.isEmpty) return;

  await TutorialManager.instance.show(
    context: dialogContext,
    tutorialId: 'dialog_tutorial_v1',
    steps: steps,
  );
}
```

---

## 🎛️ `TutorialStep` Parameters Reference

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `id` | `String` (Required) | - | Unique identifier string for the step. |
| `targetKey` | `GlobalKey` (Required) | - | The `GlobalKey` attached to the target widget. |
| `title` | `String` (Required) | - | Bold heading text on the coach mark. |
| `description` | `String` (Required) | - | Explanatory subtitle text. |
| `contentAlign` | `ContentAlign` | `ContentAlign.bottom` | Position of card (`top`, `bottom`, `left`, `right`). |
| `shape` | `ShapeLightFocus` | `ShapeLightFocus.RRect` | Highlight hole shape (`RRect` for boxes, `Circle` for icons/FABs). |
| `radius` | `double` | `12.0` | Corner border radius for `RRect`. |

---

## 🛠️ Testing & Resetting
- **Force Run:** Pass `force: true` in `TutorialManager.instance.show(...)` to ignore completion history.
- **Reset Tutorial State:** `await TutorialManager.instance.reset(MyScreenTutorial.id);`
