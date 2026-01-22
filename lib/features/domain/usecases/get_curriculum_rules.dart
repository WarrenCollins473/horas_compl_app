import 'package:horas_compl_app/features/domain/entities/curriculum_rules_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/curriculum_rules_repository.dart';

class GetCurriculumRules {
  final CurriculumRepository repository;

  GetCurriculumRules(this.repository);

  Future<CurriculumRules> call() {
    return repository.getCurriculumRules();
  }
}
