import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';
import 'package:horas_compl_app/features/domain/usecases/delete_documents_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockDocumentsRepository extends Mock implements IDocumentsRepository {}

void main() {
  late IDocumentsRepository repository;
  late DeleteDocumentsUsecase usecase;

  setUp(() {
    repository = MockDocumentsRepository();
    usecase = DeleteDocumentsUsecase(repository);
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

  test('should delete a document using the repository', () {
    when(
      () => repository.deleteDocument(tDocument.id),
    ).thenAnswer((_) async => Right(true));

    final result = usecase(tDocument.id);

    expect(result, completion(Right(true)));
    verify(() => repository.deleteDocument(tDocument.id)).called(1);
  });

  test('should return a Failure when deleting a document fails', () {
    when(
      () => repository.deleteDocument(tDocument.id),
    ).thenAnswer((_) async => Left(ServerFailure()));

    final result = usecase(tDocument.id);

    expect(result, completion(Left(ServerFailure())));
    verify(() => repository.deleteDocument(tDocument.id)).called(1);
  });
}
