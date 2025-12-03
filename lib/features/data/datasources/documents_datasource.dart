import 'package:horas_compl_app/features/data/models/isar_documents.dart';

abstract class IDocumentsDatasource {
  Future<List<DocumentsModelIsar>> getAllDocuments();
  Future<void> addDocument(DocumentsModelIsar document);
  Future<void> deleteDocument(int id);
  Future<void> updateDocument(DocumentsModelIsar document);
}
