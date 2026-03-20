import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:isar_community/isar.dart';

import 'package:horas_compl_app/features/data/datasources/documents_datasource_implementation.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';

// ========================
// MOCKS
// ========================
class MockIsar extends Mock implements Isar {}

class MockCollection extends Mock
    implements IsarCollection<DocumentsModelIsar> {}

class MockQueryBuilder extends Mock
    implements QueryBuilder<DocumentsModelIsar, DocumentsModelIsar, QWhere> {}

class FakeDocumentsModelIsar extends Fake implements DocumentsModelIsar {}

void main() {
  late DocumentsDatasourceImplementation datasource;
  late MockIsar mockIsar;
  late MockCollection mockCollection;

  setUpAll(() {
    registerFallbackValue(FakeDocumentsModelIsar());
  });

  setUp(() {
    mockIsar = MockIsar();
    mockCollection = MockCollection();

    // 👇 liga o collection ao isar
    when(() => mockIsar.documentsModelIsars).thenReturn(mockCollection);

    datasource = DocumentsDatasourceImplementation(db: mockIsar);
  });

  final tDocument = DocumentsModelIsar();

  // ========================
  // GET ALL
  // ========================
  test('Should return list of documents', () async {
    final mockQuery = MockQueryBuilder();

    when(() => mockCollection.where()).thenReturn(mockQuery);
    when(() => mockQuery.findAll()).thenAnswer((_) async => [tDocument]);

    final result = await datasource.getAllDocuments();

    expect(result, isA<List<DocumentsModelIsar>>());
    expect(result.length, 1);

    verify(() => mockCollection.where()).called(1);
    verify(() => mockQuery.findAll()).called(1);
  });

  // ========================
  // ADD
  // ========================
  test('Should call put inside writeTxn when adding', () async {
    when(() => mockIsar.writeTxn(any())).thenAnswer((invocation) async {
      final callback =
          invocation.positionalArguments.first as Future<void> Function();
      return callback();
    });

    when(() => mockCollection.put(any())).thenAnswer((_) async => 1);

    await datasource.addDocument(tDocument);

    verify(() => mockIsar.writeTxn(any())).called(1);
    verify(() => mockCollection.put(tDocument)).called(1);
  });

  // ========================
  // DELETE
  // ========================
  test('Should call delete inside writeTxn', () async {
    when(() => mockIsar.writeTxn(any())).thenAnswer((invocation) async {
      final callback =
          invocation.positionalArguments.first as Future<void> Function();
      return callback();
    });

    when(() => mockCollection.delete(any())).thenAnswer((_) async => true);

    await datasource.deleteDocument(1);

    verify(() => mockIsar.writeTxn(any())).called(1);
    verify(() => mockCollection.delete(1)).called(1);
  });

  // ========================
  // UPDATE
  // ========================
  test('Should call put inside writeTxn when updating', () async {
    when(() => mockIsar.writeTxn(any())).thenAnswer((invocation) async {
      final callback =
          invocation.positionalArguments.first as Future<void> Function();
      return callback();
    });

    when(() => mockCollection.put(any())).thenAnswer((_) async => 1);

    await datasource.updateDocument(tDocument);

    verify(() => mockIsar.writeTxn(any())).called(1);
    verify(() => mockCollection.put(tDocument)).called(1);
  });
}
