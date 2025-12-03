import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

part 'isar_documents.g.dart';

@collection
// ignore: must_be_immutable
class DocumentsModelIsar extends Equatable {
  Id id = Isar.autoIncrement;
  late String category;
  late String activity;
  late String type;
  late String observation;
  late int hours;
  late String link;

  DocumentsEntity toDomain() {
    return DocumentsEntity(
      id: id,
      category: category,
      activity: activity,
      type: type,
      observation: observation,
      hours: hours,
      link: link,
    );
  }

  static DocumentsModelIsar fromDomain(DocumentsEntity documents) {
    return DocumentsModelIsar()
      ..id = documents.id
      ..category = documents.category
      ..activity = documents.activity
      ..type = documents.type
      ..observation = documents.observation
      ..hours = documents.hours
      ..link = documents.link;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    category,
    activity,
    type,
    observation,
    hours,
    link,
  ];
}
