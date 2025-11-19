import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

class DocumentsModel extends DocumentsEntity {
  const DocumentsModel({
    required super.id,
    required super.category,
    required super.activity,
    required super.type,
    required super.observation,
    required super.hours,
    required super.link,
  });

  factory DocumentsModel.fromJson(Map<String, dynamic> json) {
    return DocumentsModel(
      id: json['id'],
      category: json['category'],
      activity: json['activity'],
      type: json['type'],
      observation: json['observation'],
      hours: json['hours'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'activity': activity,
      'type': type,
      'observation': observation,
      'hours': hours,
      'link': link,
    };
  }
}
