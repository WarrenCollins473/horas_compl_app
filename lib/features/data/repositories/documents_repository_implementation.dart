import 'package:dartz/dartz.dart';
import 'package:horas_compl_app/core/errors/exeptions.dart';
import 'package:horas_compl_app/core/errors/failure.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';

class DocumentsRepositoryImplementation extends IDocumentsRepository {
  IDocumentsDatasource datasource;

  DocumentsRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<DocumentsEntity>>> getAllDocuments() async {
    try {
      final result = await datasource.getAllDocuments();
      return Right(result.map((e) => e.toDomain()).toList());
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addDocument(DocumentsEntity document) async {
    try {
      final model = DocumentsModelIsar.fromDomain(document);
      await datasource.addDocument(model);
      return Future.value(Right(true));
    } on ServerExeption {
      return Future.value(Left(ServerFailure()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDocument(int id) async {
    try {
      await datasource.deleteDocument(id);
      return Future.value(Right(true));
    } on ServerExeption {
      return Future.value(Left(ServerFailure()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateDocument(DocumentsEntity document) async {
    try {
      await datasource.updateDocument(DocumentsModelIsar.fromDomain(document));
      return Future.value(Right(true));
    } on ServerExeption {
      return Future.value(Left(ServerFailure()));
    }
  }
}
