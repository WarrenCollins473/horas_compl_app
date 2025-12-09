import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/core/usecase.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';

class UpdateDocumentsUsecase implements Usecase {
  final IDocumentsRepository repository;

  UpdateDocumentsUsecase(this.repository);
  @override
  Future<Either<Failure, bool>> call(document) async {
    return await repository.updateDocument(document);
  }
}
