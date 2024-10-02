import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_reader/services/file_service.dart';

void main() {
  group('FileService', () {
    test('filterFiles should return all files if query is empty', () {
      List<String> files = ['file1.pdf', 'file2.pdf', 'file3.pdf'];
      String query = '';

      var result = FileService.filterFiles(files, query);

      expect(result, equals(files));
    });

    test('filterFiles should return only matching files', () {
      List<String> files = ['file1.pdf', 'test2.pdf', 'test3.pdf'];
      String query = 'test';

      var result = FileService.filterFiles(files, query);

      expect(result, equals(['test2.pdf', 'test3.pdf']));
    });
  });
}
