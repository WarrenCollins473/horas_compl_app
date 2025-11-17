import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/core/usecase.dart';
import 'package:horas_compl_app/features/domain/entities/documentsEntity.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';

class GetDocumentsUsecase implements Usecase<List<DocumentsEntity>, NoParams> {
  final IDocumentsRepository repository;

  GetDocumentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<DocumentsEntity>>> call(params) async {
    return await repository.getAllDocuments();
  }
}
