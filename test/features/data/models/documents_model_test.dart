import 'package:flutter_test/flutter_test.dart';
import 'package:horas_compl_app/features/data/models/isar_documents.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

void main() {
  final tDocumentsModel = DocumentsModelIsar()
    ..id = 1
    ..category = 'Category Test'
    ..activity = 'Activity Test'
    ..type = 'Type Test'
    ..observation = 'Observation Test'
    ..hours = 10
    ..link = 'http://testlink.com';

  test('should return a Document Entity', () {
    final result = tDocumentsModel.toDomain();
    expect(
      result,
      equals(
        DocumentsEntity(
          id: 1,
          category: 'Category Test',
          activity: 'Activity Test',
          type: 'Type Test',
          observation: 'Observation Test',
          hours: 10,
          link: 'http://testlink.com',
        ),
      ),
    );
  });

  test('should return a valid Document model Isar', () {
    final result = DocumentsModelIsar.fromDomain(
      DocumentsEntity(
        id: 1,
        category: 'Category Test',
        activity: 'Activity Test',
        type: 'Type Test',
        observation: 'Observation Test',
        hours: 10,
        link: 'http://testlink.com',
      ),
    );
    expect(result, equals(tDocumentsModel));
  });
}
