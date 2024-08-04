import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/mixin/permission_status_checker_mixin.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/permission_status_checker_service.dart';
import 'package:permission_handler/permission_handler.dart';

final class IOSPermissionStatusCheckerServiceImpl
    with PermissionStatusCheckerMixin
    implements PermissionStatusCheckerService {
  const IOSPermissionStatusCheckerServiceImpl();

  @override
  Future<PermissionCurrentStatus> fetchStorageStatus() async => PermissionCurrentStatus.granted;

  @override
  Future<PermissionCurrentStatus> fetchCameraStatus() async => await checkPermissionStatus(Permission.camera);

  @override
  Future<PermissionCurrentStatus> fetchGalleryStatus() async => await checkPermissionStatus(Permission.photos);

  @override
  Future<PermissionCurrentStatus> fetchNotificationStatus() async =>
      await checkPermissionStatus(Permission.notification);

  @override
  Future<PermissionCurrentStatus> fetchAudioStatus() async => PermissionCurrentStatus.granted;

  @override
  Future<PermissionCurrentStatus> fetchVideoStatus() async => PermissionCurrentStatus.granted;
}
