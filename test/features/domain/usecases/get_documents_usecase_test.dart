import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/core/usecase.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:horas_compl_app/features/domain/usecases/get_documents_usecase.dart';

class MockDocumentsRepository extends Mock implements IDocumentsRepository {}

void main() {
  late GetDocumentsUsecase usecase;
  late IDocumentsRepository repository;

  setUp(() {
    repository = MockDocumentsRepository();
    usecase = GetDocumentsUsecase(repository);
  });

  final tDocuments = <DocumentsEntity>[
    DocumentsEntity(
      id: 1,
      category: 'Ensino',
      activity: 'Atuação como ministrante de palestra',
      type: 'Relacionada ao curso',
      observation: '',
      hours: 30,
      link: 'www.google.com',
    ),
    DocumentsEntity(
      id: 2,
      category: 'Pesquisa',
      activity: 'Participação em projeto de pesquisa',
      type: 'Projeto financiado',
      observation: '',
      hours: 20,
      link: 'www.example.com',
    ),
  ];

  final tNoParams = NoParams();
  test('should get a document list from repository', () async {
    when(() => repository.getAllDocuments()).thenAnswer(
      (_) async => Right<Failure, List<DocumentsEntity>>(tDocuments),
    );
    final result = await usecase(tNoParams);
    expect(result, Right(tDocuments));
    verify(() => repository.getAllDocuments());
  });

  test('should return a Failure when repository fails', () async {
    when(() => repository.getAllDocuments()).thenAnswer(
      (_) async => Left<Failure, List<DocumentsEntity>>(ServerFailure()),
    );
    final result = await usecase(tNoParams);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getAllDocuments());
  });
}
