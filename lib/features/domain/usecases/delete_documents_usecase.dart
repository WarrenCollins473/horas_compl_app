import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/core/usecase.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';

class DeleteDocumentsUsecase implements Usecase {
  final IDocumentsRepository repository;

  DeleteDocumentsUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(id) async {
    return await repository.deleteDocument(id);
  }
}
