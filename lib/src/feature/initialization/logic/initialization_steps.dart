import 'dart:async';
import 'dart:io';

import 'package:permission_checker/src/feature/initialization/model/initialization_proccess.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/android_permission_status_checker_service_impl.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/ios_permission_status_checker_service_impl.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/permission_status_checker_service.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/repository/permission_status_checker_repository_impl.dart';


/// A function which represents a single initialization step.
typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// The initialization steps, which are executed in the order they are defined.
///
/// The [Dependencies] object is passed to each step, which allows the step to
/// set the dependency, and the next step to use it.
mixin InitializationSteps {
  /// The initialization steps,
  /// which are executed in the order they are defined.
  final initializationSteps = <String, StepAction>{
    'Permission Status Checker': (progress) {
      final permissionStatusCheckerService =
          _fetchPermissionStatusCheckerService();
      progress.dependencies.permissionStatusCheckerRepository =
          PermissionStatusCheckerRepositoryImpl(
        permissionStatusCheckerService: permissionStatusCheckerService,
      );
    },
  };

  static PermissionStatusCheckerService _fetchPermissionStatusCheckerService() {
    if (Platform.isAndroid) {
      return const AndroidPermissionStatusCheckerServiceImpl();
    } else if (Platform.isIOS) {
      return const IOSPermissionStatusCheckerServiceImpl();
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
