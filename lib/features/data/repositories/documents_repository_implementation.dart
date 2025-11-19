import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/exeptions.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';

class DocumentsRepositoryImplementation extends IDocumentsRepository {
  IDocumentsDatasource datasource;

  DocumentsRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<DocumentsEntity>>> getAllDocuments() async {
    try {
      final result = await datasource.getAllDocuments();
      return Right(result);
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
}
