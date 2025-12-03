import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:isar_community/isar.dart';

class DocumentsDatasourceImplementation implements IDocumentsDatasource {
  late Isar db;

  DocumentsDatasourceImplementation({required this.db});

  @override
  Future<List<DocumentsModelIsar>> getAllDocuments() {
    return db.documentsModelIsars.where().findAll();
  }

  @override
  Future<void> addDocument(DocumentsModelIsar document) {
    return db.writeTxn(() => db.documentsModelIsars.put(document));
  }

  @override
  Future<void> deleteDocument(int id) async {
    await db.writeTxn(() => db.documentsModelIsars.delete(id));
  }

  @override
  Future<void> updateDocument(DocumentsModelIsar document) async {
    await db.writeTxn(() => db.documentsModelIsars.put(document));
  }
}
