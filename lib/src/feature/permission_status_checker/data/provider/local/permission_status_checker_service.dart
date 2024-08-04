import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';

abstract interface class PermissionStatusCheckerService {
  Future<PermissionCurrentStatus> fetchStorageStatus();

  Future<PermissionCurrentStatus> fetchCameraStatus();

  Future<PermissionCurrentStatus> fetchGalleryStatus();

  Future<PermissionCurrentStatus> fetchNotificationStatus();

  Future<PermissionCurrentStatus> fetchAudioStatus();

  Future<PermissionCurrentStatus> fetchVideoStatus();
}
