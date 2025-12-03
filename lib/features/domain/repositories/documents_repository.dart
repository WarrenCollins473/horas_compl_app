import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

abstract class IDocumentsRepository {
  Future<Either<Failure, List<DocumentsEntity>>> getAllDocuments();
  Future<Either<Failure, void>> addDocument(DocumentsEntity document);
  Future<Either<Failure, void>> deleteDocument(int id);
  Future<Either<Failure, void>> updateDocument(DocumentsEntity document);
}
