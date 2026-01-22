import 'package:equatable/equatable.dart';
import 'package:horas_compl_app/features/domain/entities/activity_type_entity.dart';

class Activity extends Equatable {
  final String name;

  /// Atividade simples
  final int? individualHours;
  final int? maximumHours;

  /// Atividade com subdivisões
  final List<ActivityType>? types;

  const Activity({
    required this.name,
    this.individualHours,
    this.maximumHours,
    this.types,
  });

  bool get hasTypes => types != null && types!.isNotEmpty;

  @override
  List<Object?> get props => [name, individualHours, maximumHours, types];
}
