import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_reader/utils/permissions_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([PermissionStatus])
void main() {
  test('checkStoragePermission should return true when permission is granted', () async {
    var status = PermissionStatus.granted;

    var result = await checkStoragePermission();
    expect(result, equals(true));
  });

  test('checkStoragePermission should return false when permission is denied', () async {
    var status = PermissionStatus.denied;
    var result = await checkStoragePermission();
    expect(result, equals(false));
  });
}
