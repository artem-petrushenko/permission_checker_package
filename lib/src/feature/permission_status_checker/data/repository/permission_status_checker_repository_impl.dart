import 'package:permission_checker/src/feature/permission_status_checker/data/enum/permission_status_enum.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/provider/local/permission_status_checker_service.dart';
import 'package:permission_checker/src/feature/permission_status_checker/data/repository/permission_status_checker_repository.dart';

final class PermissionStatusCheckerRepositoryImpl implements PermissionStatusCheckerRepository {
  const PermissionStatusCheckerRepositoryImpl({
    required final PermissionStatusCheckerService permissionStatusCheckerService,
  }) : _permissionStatusCheckerService = permissionStatusCheckerService;

  final PermissionStatusCheckerService _permissionStatusCheckerService;

  @override
  Future<PermissionCurrentStatus> checkPermissionStatus(
    PermissionType permission,
  ) async =>
      switch (permission) {
        PermissionType.storage => _permissionStatusCheckerService.fetchStorageStatus(),
        PermissionType.camera => _permissionStatusCheckerService.fetchCameraStatus(),
        PermissionType.notification => _permissionStatusCheckerService.fetchNotificationStatus(),
        PermissionType.photos => _permissionStatusCheckerService.fetchGalleryStatus(),
        PermissionType.video => _permissionStatusCheckerService.fetchVideoStatus(),
        PermissionType.audio => _permissionStatusCheckerService.fetchAudioStatus(),
      };
}
