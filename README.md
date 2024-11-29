# PermissionHandler Package

`PermissionHandler` is a convenient Flutter widget designed to simplify working with permissions. It helps developers
avoid the hassle of manually managing permissions for different operating system versions.

## Features

- Easy integration: Handle permissions in one place.
- Supports multiple OS versions.
- Customizable behavior:
    - Logic for successful permission granting.
    - Logic for handling user denial.

## Installation

Add `permission_handler` to your project's pubspec.yaml file:

```yaml
dependencies:
  permission_handler: ^0.0.1
```

## Usage Example

```dart
PermissionHandler(
  permission: PermissionType.photos, // Type of permission required
  onAfterTap: () {}, // Logic after successful permission grant
  widget: (onTap) => ElevatedButton(
    onPressed: onTap,
    child: const Text('Photos'),
  ), // Widget to trigger permission request
  onFailedTap: () => showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) => const PermissionAlertDialog(),
  ), // Logic when the user denies permission
);
```

## Real-World Applications

This widget is ideal for applications requiring access to resources like the camera, photo albums, location, or any
other permissions-dependent functionality.