import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf_reader/screens/home_screen.dart';
import 'package:pdf_reader/services/file_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks([FileService])
void main() {
  testWidgets('HomeScreen displays PDF files', (WidgetTester tester) async {
    final mockFileService = MockFileService();
    when(mockFileService.getPdfFiles(any)).thenAnswer((_) async => ['file1.pdf', 'file2.pdf']);
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('file1.pdf'), findsOneWidget);
    expect(find.text('file2.pdf'), findsOneWidget);
  });

  testWidgets('HomeScreen displays search bar when search icon is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });
}
