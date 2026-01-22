import 'package:equatable/equatable.dart';
import 'package:horas_compl_app/features/domain/entities/curriculum_rules_entity.dart';

class CurriculumRulesState extends Equatable {
  final bool isLoading;
  final CurriculumRules? rules;
  final String? error;

  const CurriculumRulesState({required this.isLoading, this.rules, this.error});

  factory CurriculumRulesState.initial() {
    return const CurriculumRulesState(
      isLoading: false,
      rules: null,
      error: null,
    );
  }

  CurriculumRulesState copyWith({
    bool? isLoading,
    CurriculumRules? rules,
    String? error,
  }) {
    return CurriculumRulesState(
      isLoading: isLoading ?? this.isLoading,
      rules: rules ?? this.rules,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, rules, error];
}
