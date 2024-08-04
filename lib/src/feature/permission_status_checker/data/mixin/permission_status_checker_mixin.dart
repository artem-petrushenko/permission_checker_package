import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_handler/permission_handler.dart';

mixin PermissionStatusCheckerMixin {
  Future<PermissionCurrentStatus> checkPermissionStatus(
    Permission permission,
  ) async {
    try {
      await permission.request();
      final permissionStatus = await permission.status;
      switch (permissionStatus) {
        case PermissionStatus.denied:
          return PermissionCurrentStatus.denied;
        case PermissionStatus.granted:
          return PermissionCurrentStatus.granted;
        case PermissionStatus.restricted:
          return PermissionCurrentStatus.restricted;
        case PermissionStatus.limited:
          return PermissionCurrentStatus.limited;
        case PermissionStatus.permanentlyDenied:
          return PermissionCurrentStatus.permanentlyDenied;
        case PermissionStatus.provisional:
          return PermissionCurrentStatus.provisional;
      }
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
