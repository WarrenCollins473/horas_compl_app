import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

abstract class IDocumentsRepository {
  Future<Either<Failure, List<DocumentsEntity>>> getAllDocuments();
  Future<Either<Failure, bool>> addDocument(DocumentsEntity document);
  Future<Either<Failure, bool>> deleteDocument(int id);
  Future<Either<Failure, bool>> updateDocument(DocumentsEntity document);
}
