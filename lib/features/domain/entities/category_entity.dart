import 'package:equatable/equatable.dart';
import 'package:horas_compl_app/features/domain/entities/activity_entity.dart';

class Category extends Equatable {
  final String name;
  final int categoryLimit;
  final List<Activity> activities;

  const Category({
    required this.name,
    required this.categoryLimit,
    required this.activities,
  });

  @override
  List<Object> get props => [name, categoryLimit, activities];
}
