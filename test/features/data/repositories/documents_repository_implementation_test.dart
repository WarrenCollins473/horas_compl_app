import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/core/errors/exeptions.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/models/documents_modelo.dart';
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

  final tDocumentsModel = <DocumentsModel>[
    DocumentsModel(
      id: 1,
      category: 'Ensino',
      activity: 'Atuação como ministrante de palestra',
      type: 'Relacionada ao curso',
      observation: '',
      hours: 30,
      link: 'www.google.com',
    ),
    DocumentsModel(
      id: 2,
      category: 'Pesquisa',
      activity: 'Participação em projeto de pesquisa',
      type: 'Projeto financiado',
      observation: '',
      hours: 20,
      link: 'www.example.com',
    ),
  ];
  test("should return a list of documents when call the datasource", () async {
    when(
      () => datasource.getAllDocuments(),
    ).thenAnswer((_) async => tDocumentsModel);

    final result = await repository.getAllDocuments();

    expect(result, Right(tDocumentsModel));
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
}
