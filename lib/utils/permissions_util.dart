import 'package:permission_handler/permission_handler.dart';

Future<bool> checkStoragePermission() async {
  PermissionStatus status = await Permission.manageExternalStorage.request();
  return status.isGranted;
}
