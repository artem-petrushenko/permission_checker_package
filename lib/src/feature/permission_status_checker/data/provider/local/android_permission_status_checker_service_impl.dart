import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/mixin/permission_status_checker_mixin.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/permission_status_checker_service.dart';
import 'package:permission_handler/permission_handler.dart';

final class AndroidPermissionStatusCheckerServiceImpl
    with PermissionStatusCheckerMixin
    implements PermissionStatusCheckerService {
  const AndroidPermissionStatusCheckerServiceImpl();

  @override
  Future<PermissionCurrentStatus> fetchStorageStatus() async => await _storageInSdk33(Permission.manageExternalStorage);

  @override
  Future<PermissionCurrentStatus> fetchCameraStatus() async => await checkPermissionStatus(Permission.camera);

  @override
  Future<PermissionCurrentStatus> fetchGalleryStatus() async => await _storageInSdk33(Permission.photos);

  @override
  Future<PermissionCurrentStatus> fetchNotificationStatus() async =>
      await checkPermissionStatus(Permission.notification);

  @override
  Future<PermissionCurrentStatus> fetchAudioStatus() async => await _storageInSdk33(Permission.audio);

  @override
  Future<PermissionCurrentStatus> fetchVideoStatus() async => await _storageInSdk33(Permission.videos);

  Future<PermissionCurrentStatus> _storageInSdk33(
    Permission permission,
  ) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    if (android.version.sdkInt >= 33) return await checkPermissionStatus(permission);
    return await checkPermissionStatus(Permission.storage);
  }
}
