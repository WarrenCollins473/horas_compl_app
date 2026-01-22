import 'package:horas_compl_app/features/domain/entities/curriculum_rules_entity.dart';

abstract class CurriculumRepository {
  Future<CurriculumRules> getCurriculumRules();
}
