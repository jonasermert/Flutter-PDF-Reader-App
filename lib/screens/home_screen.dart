import 'package:flutter/material.dart';
import 'package:pdf_reader/screens/pdf_viewer_screen.dart';
import 'package:pdf_reader/services/file_service.dart';
import 'package:pdf_reader/utils/permissions_util.dart';
import 'package:path/path.dart' as path;

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
    _loadPdfFiles();
  }

  Future<void> _loadPdfFiles() async {
    if (await checkStoragePermission()) {
      String directory = await FileService.getDownloadDirectory();
      List<String> files = await FileService.getPdfFiles(directory);
      setState(() {
        _pdfFiles = files;
        _filteredFiles = files;
      });
    }
  }

  void _filterFiles(String query) {
    setState(() {
      _filteredFiles = FileService.filterFiles(_pdfFiles, query);
    });
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
            : SearchBar(onChanged: _filterFiles),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                _filteredFiles = _pdfFiles;
              });
            },
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
          ),
        ],
      ),
      body: _filteredFiles.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _filteredFiles.length,
        itemBuilder: (context, index) {
          String filePath = _filteredFiles[index];
          String fileName = path.basename(filePath);
          return Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                fileName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.picture_as_pdf,
                color: Colors.redAccent,
                size: 30,
              ),
              trailing: Icon(Icons.arrow_forward, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(
                      pdfName: fileName,
                      pdfPath: filePath,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadPdfFiles,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
