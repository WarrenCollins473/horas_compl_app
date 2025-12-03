import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/core/errors/exeptions.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:horas_compl_app/features/data/repositories/documents_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';

class MockDocumentsDatasource extends Mock implements IDocumentsDatasource {}

void main() {
  late DocumentsRepositoryImplementation repository;
  late IDocumentsDatasource datasource;
  setUp(() {
    datasource = MockDocumentsDatasource();
    repository = DocumentsRepositoryImplementation(datasource: datasource);
  });

  final tDocumentsModelIsar = <DocumentsModelIsar>[
    DocumentsModelIsar()
      ..id = 1
      ..category = 'Category Test 1'
      ..activity = 'Activity Test 1'
      ..type = 'Type Test 1'
      ..observation = 'Observation Test 1'
      ..hours = 10
      ..link = 'http://testlink1.com',
    DocumentsModelIsar()
      ..id = 2
      ..category = 'Category Test 2'
      ..activity = 'Activity Test 2'
      ..type = 'Type Test 2'
      ..observation = 'Observation Test 2'
      ..hours = 20
      ..link = 'http://testlink2.com',
  ];

  final tDocumentToAdd = DocumentsModelIsar()
    ..id = 3
    ..category = 'Category Test 3'
    ..activity = 'Activity Test 3'
    ..type = 'Type Test 3'
    ..observation = 'Observation Test 3'
    ..hours = 30
    ..link = 'http://testlink3.com';

  final tDocumentsEntity = tDocumentsModelIsar
      .map((e) => e.toDomain())
      .toList();
  test("should return a list of documents when call the datasource", () async {
    when(
      () => datasource.getAllDocuments(),
    ).thenAnswer((_) async => tDocumentsModelIsar);

    final result = await repository.getAllDocuments();

    result.fold(
      (l) => fail('Expected Right but got Left: $l'),
      (r) => expect(r, equals(tDocumentsEntity)),
    );

    verify(() => datasource.getAllDocuments()).called(1);
  });

  test(
    'Should return a server failure when the call to datasource is unsucessful',
    () async {
      when(() => datasource.getAllDocuments()).thenThrow(ServerExeption());

      final result = await repository.getAllDocuments();

      expect(result, Left(ServerFailure()));
      verify(() => datasource.getAllDocuments()).called(1);
    },
  );
  test('Should call the datasource to add a document', () async {
    when(
      () => datasource.addDocument(tDocumentToAdd),
    ).thenAnswer((_) async => Future.value());

    final result = await repository.addDocument(tDocumentToAdd.toDomain());

    result.fold(
      (l) => fail('Expected Right but got Left: $l'),
      (r) => expect(r, equals(true)),
    );

    verify(() => datasource.addDocument(tDocumentToAdd)).called(1);
  });
  test('shoud return a server failure when the call of datasource fails', () {
    when(
      () => datasource.addDocument(tDocumentToAdd),
    ).thenThrow(ServerExeption());

    final result = repository.addDocument(tDocumentToAdd.toDomain());

    expect(result, completion(Left(ServerFailure())));
    verify(() => datasource.addDocument(tDocumentToAdd)).called(1);
  });

  test('Should call the datasource to delete a document', () {
    int id = 1;
    when(
      () => datasource.deleteDocument(id),
    ).thenAnswer((_) async => Future.value());
    final result = repository.deleteDocument(id);
    expect(result, completion(Right(true)));
    verify(() => datasource.deleteDocument(id)).called(1);
  });

  test('shoud return a server failure when the call of datasource fails', () {
    int id = 1;
    when(() => datasource.deleteDocument(id)).thenThrow(ServerExeption());

    final result = repository.deleteDocument(id);

    expect(result, completion(Left(ServerFailure())));
    verify(() => datasource.deleteDocument(id)).called(1);
  });

  test('Should call the datasource to update a document', () {
    when(
      () => datasource.updateDocument(tDocumentToAdd),
    ).thenAnswer((_) async => Future.value());
    final result = repository.updateDocument(tDocumentToAdd.toDomain());

    expect(result, completion(Right(true)));
    verify(() => datasource.updateDocument(tDocumentToAdd)).called(1);
  });

  test('shoud return a server failure when the call of datasource fails', () {
    when(
      () => datasource.updateDocument(tDocumentToAdd),
    ).thenThrow(ServerExeption());

    final result = repository.updateDocument(tDocumentToAdd.toDomain());

    expect(result, completion(Left(ServerFailure())));
    verify(() => datasource.updateDocument(tDocumentToAdd)).called(1);
  });
}
