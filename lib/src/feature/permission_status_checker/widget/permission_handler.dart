import 'package:flutter/material.dart';
import 'package:permission_checker/src/feature/initialization/widget/dependency_scope.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_checker/src/feature/permission_status_checker/widget/scope/permission_scope.dart';

class PermissionHandler extends StatelessWidget {
  const PermissionHandler({
    super.key,
    required this.permission,
    required this.onAfterTap,
    required this.widget,
    required this.onFailedTap,
  });

  final PermissionType permission;
  final VoidCallback onAfterTap;
  final VoidCallback onFailedTap;
  final Widget Function(VoidCallback onTap) widget;

  @override
  Widget build(BuildContext context) => PermissionStatusCheckerScope(
        permission: permission,
        permissionStatusCheckerRepository: DependenciesScope.of(context).permissionStatusCheckerRepository,
        child: _PermissionStatusChecker(
          permission: permission,
          onAfterTap: onAfterTap,
          widget: widget,
          onFailedTap: onFailedTap,
        ),
      );
}

class _PermissionStatusChecker extends StatelessWidget {
  const _PermissionStatusChecker({
    required this.permission,
    required this.onAfterTap,
    required this.widget,
    required this.onFailedTap,
  });

  final PermissionType permission;
  final VoidCallback onAfterTap;
  final VoidCallback onFailedTap;
  final Widget Function(VoidCallback onTap) widget;

  @override
  Widget build(BuildContext context) => widget(
        () async {
          final permissionStatus = await PermissionStatusCheckerScope.of(context)?.checkPermissionStatus();
          if (context.mounted) {
            if (permissionStatus == OutputPermissionStatus.granted) {
              onAfterTap();
            } else {
              onFailedTap();
            }
          }
        },
      );
}
