import 'package:horas_compl_app/features/domain/entities/activity_type_entity.dart';

class ActivityTypeModel extends ActivityType {
  const ActivityTypeModel({
    required super.name,
    required super.individualHours,
    required super.maximumHours,
  });

  factory ActivityTypeModel.fromJson(Map<String, dynamic> json) {
    return ActivityTypeModel(
      name: json['nome'] as String,
      individualHours: json['carga_individual'] as int,
      maximumHours: json['carga_maxima'] as int,
    );
  }
}
