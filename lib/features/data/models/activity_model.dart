import 'package:horas_compl_app/features/data/models/activity_type_model.dart';
import 'package:horas_compl_app/features/domain/entities/activity_entity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required super.name,
    super.individualHours,
    super.maximumHours,
    super.types,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      name: json['nome'] as String,
      individualHours: json['carga_individual'],
      maximumHours: json['carga_maxima'],
      types: json['tipos'] != null
          ? (json['tipos'] as List)
                .map((e) => ActivityTypeModel.fromJson(e))
                .toList()
          : null,
    );
  }
}
