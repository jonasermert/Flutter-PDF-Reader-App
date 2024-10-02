import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_reader/screens/pdf_viewer_screen.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

void main() {
  testWidgets('PdfViewerScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PdfViewerScreen(
        pdfName: 'Sample PDF',
        pdfPath: 'path/to/sample.pdf',
      ),
    ));

    expect(find.text('Sample PDF'), findsOneWidget);
    expect(find.byType(PDFView), findsOneWidget);
  });
}
