import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _pdfFiles = [];
  List<String> _filteredFiles = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    baseDirectory();
  }

  Future<void> baseDirectory() async {
    PermissionStatus permissionStatus =
        await Permission.manageExternalStorage.request();
    if (permissionStatus.isGranted) {
      var rootDirectory = await ExternalPath.getExternalStorageDirectories();
      await getFiles(rootDirectory.first);
    }
  }

  Future<void> getFiles(String directoryPath) async {
    try {
      var rootDirectory = Directory(directoryPath);
      var directories = rootDirectory.list(recursive: false);

      await for (var element in directories) {
        if (element is File) {
          if (element.path.endsWith('.pdf')) {
            setState(() {
              _pdfFiles.add(element.path);
              _filteredFiles = _pdfFiles;
            });
          }
        } else {
          await getFiles(element.path);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _filterFiles(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredFiles = _pdfFiles;
      });
    } else {
      setState(() {
        _filteredFiles = _pdfFiles
            .where((file) => file
                .split('/')
                .last
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: !_isSearching
              ? Text(
                  "PDF Reader",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              : TextField(
                  decoration: InputDecoration(
                    hintText: "Search PDFs...",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {},
                )),
    );
  }
}
