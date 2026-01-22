import 'package:equatable/equatable.dart';

abstract class CurriculumRulesEvent extends Equatable {
  const CurriculumRulesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurriculumRules extends CurriculumRulesEvent {
  const LoadCurriculumRules();
}
