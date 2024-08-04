import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';

abstract interface class PermissionStatusCheckerRepository {
  Future<PermissionCurrentStatus> checkPermissionStatus(PermissionType permission);
}
