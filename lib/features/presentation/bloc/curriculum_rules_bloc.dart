import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/domain/usecases/get_curriculum_rules.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_events.dart';
import 'curriculum_rules_state.dart';

class CurriculumRulesBloc
    extends Bloc<CurriculumRulesEvent, CurriculumRulesState> {
  final GetCurriculumRules getCurriculumRules;

  CurriculumRulesBloc(this.getCurriculumRules)
    : super(CurriculumRulesState.initial()) {
    on<LoadCurriculumRules>(_onLoadCurriculumRules);
  }

  Future<void> _onLoadCurriculumRules(
    LoadCurriculumRules event,
    Emitter<CurriculumRulesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final rules = await getCurriculumRules();
      emit(state.copyWith(isLoading: false, rules: rules));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
