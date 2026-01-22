import 'package:equatable/equatable.dart';
import 'package:horas_compl_app/features/domain/entities/category_entity.dart';

class CurriculumRules extends Equatable {
  final List<Category> categories;
  final int minimumTotalHours;

  const CurriculumRules({
    required this.categories,
    required this.minimumTotalHours,
  });

  @override
  List<Object> get props => [categories, minimumTotalHours];
}
