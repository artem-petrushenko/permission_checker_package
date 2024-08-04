import 'package:flutter/material.dart';
import 'package:permission_checker/src/core/logger.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/repository/permission_status_checker_repository.dart';

class PermissionStatusCheckerScope extends InheritedWidget {
  final PermissionStatusCheckerRepository _permissionStatusCheckerRepository;
  final PermissionType _permission;

  const PermissionStatusCheckerScope({
    super.key,
    required super.child,
    required PermissionType permission,
    required PermissionStatusCheckerRepository permissionStatusCheckerRepository,
  })  : _permission = permission,
        _permissionStatusCheckerRepository = permissionStatusCheckerRepository;

  static PermissionStatusCheckerScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PermissionStatusCheckerScope>();
  }

  @override
  bool updateShouldNotify(covariant PermissionStatusCheckerScope oldWidget) {
    return oldWidget._permission != _permission ||
        oldWidget._permissionStatusCheckerRepository != _permissionStatusCheckerRepository;
  }

  Future<OutputPermissionStatus> checkPermissionStatus() async {
    try {
      PermissionCurrentStatus permissionStatus =
          await _permissionStatusCheckerRepository.checkPermissionStatus(_permission);
      return switch (permissionStatus) {
        PermissionCurrentStatus.granted => OutputPermissionStatus.granted,
        PermissionCurrentStatus.denied => OutputPermissionStatus.denied,
        PermissionCurrentStatus.restricted => OutputPermissionStatus.granted,
        PermissionCurrentStatus.permanentlyDenied => OutputPermissionStatus.denied,
        PermissionCurrentStatus.limited => OutputPermissionStatus.granted,
        PermissionCurrentStatus.provisional => OutputPermissionStatus.granted,
      };
    } catch (error, stackTrace) {
      logger.error('Error:', error: error, stackTrace: stackTrace);
      return OutputPermissionStatus.denied;
    }
  }
}
