import 'package:horas_compl_app/features/data/models/activity_model.dart';
import 'package:horas_compl_app/features/domain/entities/category_entity.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.name,
    required super.categoryLimit,
    required super.activities,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['nome'] as String,
      categoryLimit: json['limite_categoria'] as int,
      activities: (json['atividades'] as List)
          .map((e) => ActivityModel.fromJson(e))
          .toList(),
    );
  }
}
