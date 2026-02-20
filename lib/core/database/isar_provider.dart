import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarProvider {
  static Future<Isar> open() async {
    final dir = await getApplicationDocumentsDirectory();

    return Isar.open([DocumentsModelIsarSchema], directory: dir.path);
  }
}
