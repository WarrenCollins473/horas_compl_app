import 'package:horas_compl_app/features/data/models/documents_modelo.dart';

abstract class IDocumentsDatasource {
  Future<List<DocumentsModel>> getAllDocuments();
}
