import 'package:horas_compl_app/features/domain/entities/curriculum_rules_entity.dart';
import 'package:horas_compl_app/features/domain/repositories/curriculum_rules_repository.dart';
import '../datasources/curriculum_local_datasource.dart';
import '../models/curriculum_rules_model.dart';

class CurriculumRepositoryImpl implements CurriculumRepository {
  final CurriculumLocalDatasource datasource;

  CurriculumRepositoryImpl(this.datasource);

  @override
  Future<CurriculumRules> getCurriculumRules() async {
    final json = await datasource.loadCurriculum();

    return CurriculumRulesModel.fromJson(json);
  }
}
