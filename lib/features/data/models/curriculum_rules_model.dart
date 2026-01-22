import 'package:horas_compl_app/features/data/models/category_model.dart';
import 'package:horas_compl_app/features/domain/entities/curriculum_rules_entity.dart';

class CurriculumRulesModel extends CurriculumRules {
  const CurriculumRulesModel({
    required super.categories,
    required super.minimumTotalHours,
  });

  factory CurriculumRulesModel.fromJson(Map<String, dynamic> json) {
    return CurriculumRulesModel(
      minimumTotalHours: json['total_minimo'] as int,
      categories: (json['categorias'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }
}
