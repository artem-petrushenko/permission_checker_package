import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class PermissionAlertDialog extends StatelessWidget {
  const PermissionAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Error'),
      actions: [
        TextButton(
          onPressed: () => AppSettings.openAppSettings(type: AppSettingsType.settings),
          child: const Text('Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
