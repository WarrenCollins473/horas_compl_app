import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';
import 'package:horas_compl_app/features/domain/usecases/add_documents_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockDocumentsRepository extends Mock implements IDocumentsRepository {}

void main() {
  late AddDocumentsUsecase usecase;
  late IDocumentsRepository repository;

  setUp(() {
    repository = MockDocumentsRepository();
    usecase = AddDocumentsUsecase(repository);
  });

  final tDocument = DocumentsEntity(
    id: 2,
    category: 'Pesquisa',
    activity: 'Participação em projeto de pesquisa',
    type: 'Projeto financiado',
    observation: '',
    hours: 20,
    link: 'www.example.com',
  );
  test('should add a document using the repository ', () {
    when(
      () => repository.addDocument(tDocument),
    ).thenAnswer((_) async => Right(true));
    final result = usecase(tDocument);
    expect(result, completion(Right(true)));
    verify(() => repository.addDocument(tDocument));
  });

  test('should return a Failure when adding a document fails', () {
    when(
      () => repository.addDocument(tDocument),
    ).thenAnswer((_) async => Left(ServerFailure()));
    final result = usecase(tDocument);
    expect(result, completion(Left(ServerFailure())));
    verify(() => repository.addDocument(tDocument));
  });
}
