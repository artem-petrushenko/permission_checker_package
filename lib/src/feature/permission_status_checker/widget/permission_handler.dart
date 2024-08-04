import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_checker/src/core/error/exeptions.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/android_permission_status_checker_service_impl.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/ios_permission_status_checker_service_impl.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/permission_status_checker_service.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/repository/permission_status_checker_repository.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/repository/permission_status_checker_repository_impl.dart';
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
        permissionStatusCheckerRepository: Dependencies().permissionStatusCheckerRepository,
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

class Dependencies {
  final PermissionStatusCheckerRepository _permissionStatusCheckerRepository = PermissionStatusCheckerRepositoryImpl(
    permissionStatusCheckerService: _fetchPermissionStatusCheckerService(),
  );

  static PermissionStatusCheckerService _fetchPermissionStatusCheckerService() {
    if (Platform.isAndroid) {
      return const AndroidPermissionStatusCheckerServiceImpl();
    } else if (Platform.isIOS) {
      return const IOSPermissionStatusCheckerServiceImpl();
    } else {
      throw UnsupportedPlatformException();
    }
  }

  PermissionStatusCheckerRepository get permissionStatusCheckerRepository => _permissionStatusCheckerRepository;
}
