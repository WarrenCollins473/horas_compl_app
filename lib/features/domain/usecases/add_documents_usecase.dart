import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/core/usecase.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';

class AddDocumentsUsecase implements Usecase<bool, DocumentsEntity> {
  final IDocumentsRepository repository;

  AddDocumentsUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DocumentsEntity document) async {
    return await repository.addDocument(document);
  }
}
