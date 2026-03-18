import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:horas_compl_app/core/errors/exeptions.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/data/repositories/documents_repository_implementation.dart';

class MockDocumentsDatasource extends Mock implements IDocumentsDatasource {}

class FakeDocumentsModelIsar extends Fake implements DocumentsModelIsar {}

void main() {
  late DocumentsRepositoryImplementation repository;
  late MockDocumentsDatasource datasource;

  setUpAll(() {
    registerFallbackValue(FakeDocumentsModelIsar());
  });

  setUp(() {
    datasource = MockDocumentsDatasource();
    repository = DocumentsRepositoryImplementation(datasource: datasource);
  });

  final tEntity = DocumentsEntity(
    id: 1,
    category: 'Category',
    activity: 'Activity',
    type: 'Type',
    observation: 'Obs',
    hours: 10,
    link: 'link',
  );

  final tModel = DocumentsModelIsar.fromDomain(tEntity);

  final tModelList = [tModel];

  // ========================
  // GET ALL
  // ========================
  test('Should return list of DocumentsEntity when success', () async {
    when(
      () => datasource.getAllDocuments(),
    ).thenAnswer((_) async => tModelList);

    final result = await repository.getAllDocuments();

    expect(result, isA<Right>());
    result.fold((l) => fail('Should not return Left'), (r) {
      expect(r.length, 1);
      expect(r.first.category, tEntity.category);
    });

    verify(() => datasource.getAllDocuments()).called(1);
  });

  test('Should return ServerFailure when getAllDocuments throws', () async {
    when(() => datasource.getAllDocuments()).thenThrow(ServerExeption());

    final result = await repository.getAllDocuments();

    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<ServerFailure>()),
      (r) => fail('Should not return Right'),
    );
  });

  // ========================
  // ADD
  // ========================
  test('Should return true when addDocument is successful', () async {
    when(() => datasource.addDocument(any())).thenAnswer((_) async {});

    final result = await repository.addDocument(tEntity);

    expect(result, equals(const Right(true)));

    verify(() => datasource.addDocument(any())).called(1);
  });

  test('Should return ServerFailure when addDocument throws', () async {
    when(() => datasource.addDocument(any())).thenThrow(ServerExeption());

    final result = await repository.addDocument(tEntity);

    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<ServerFailure>()),
      (r) => fail('Should not return Right'),
    );
  });

  // ========================
  // DELETE
  // ========================
  test('Should return true when deleteDocument is successful', () async {
    when(() => datasource.deleteDocument(any())).thenAnswer((_) async {});

    final result = await repository.deleteDocument(1);

    expect(result, equals(const Right(true)));

    verify(() => datasource.deleteDocument(1)).called(1);
  });

  test('Should return ServerFailure when deleteDocument throws', () async {
    when(() => datasource.deleteDocument(any())).thenThrow(ServerExeption());

    final result = await repository.deleteDocument(1);

    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<ServerFailure>()),
      (r) => fail('Should not return Right'),
    );
  });

  // ========================
  // UPDATE
  // ========================
  test('Should return true when updateDocument is successful', () async {
    when(() => datasource.updateDocument(any())).thenAnswer((_) async {});

    final result = await repository.updateDocument(tEntity);

    expect(result, equals(const Right(true)));

    verify(() => datasource.updateDocument(any())).called(1);
  });

  test('Should return ServerFailure when updateDocument throws', () async {
    when(() => datasource.updateDocument(any())).thenThrow(ServerExeption());

    final result = await repository.updateDocument(tEntity);

    expect(result, isA<Left>());
    result.fold(
      (l) => expect(l, isA<ServerFailure>()),
      (r) => fail('Should not return Right'),
    );
  });
}
