import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource_implementation.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:isar_community/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

// Future<void> main() async {
//   late IDocumentsDatasource datasource;

//   setUp(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Isar.initializeIsarCore(download: true);
//     final dir = await getApplicationCacheDirectory();
//     final isar = await Isar.open([
//       DocumentsModelIsarSchema,
//     ], directory: dir.path);
//     datasource = DocumentsDatasourceImplementation(db: isar);
//   });

//   test('shoud get all documents', () {
//     when(
//       () => datasource.getAllDocuments(),
//     ).thenAnswer((_) async => <DocumentsModelIsar>[]);
//     final result = datasource.getAllDocuments();
//     expect(result, isA<Future<List<DocumentsModelIsar>>>());
//   });
// }
