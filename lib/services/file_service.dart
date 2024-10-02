import 'dart:io';
import 'package:path/path.dart' as path;

class FileService {
  static Future<String> getDownloadDirectory() async {
    return "/storage/emulated/0/Download";
  }

  static Future<List<String>> getPdfFiles(String directoryPath) async {
    List<String> pdfFiles = [];
    try {
      var directory = Directory(directoryPath);
      var files = directory.listSync(recursive: false);

      for (var element in files) {
        if (element is File && element.path.endsWith('.pdf')) {
          pdfFiles.add(element.path);
        } else if (element is Directory) {
          pdfFiles.addAll(await getPdfFiles(element.path));
        }
      }
    } catch (e) {
      print(e);
    }
    return pdfFiles;
  }

  static List<String> filterFiles(List<String> files, String query) {
    if (query.isEmpty) {
      return files;
    } else {
      return files
          .where((file) => path.basename(file).toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
