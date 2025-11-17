import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/domain/entities/documentsEntity.dart';

abstract class IDocumentsRepository {
  Future<Either<Failure, List<DocumentsEntity>>> getAllDocuments();
}
