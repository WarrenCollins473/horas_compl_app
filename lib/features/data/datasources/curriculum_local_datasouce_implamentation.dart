import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:horas_compl_app/features/data/datasources/curriculum_local_datasource.dart';

class CurriculumLocalDatasourceImpl implements CurriculumLocalDatasource {
  @override
  Future<Map<String, dynamic>> loadCurriculum() async {
    final jsonString = await rootBundle.loadString('assets/data/barema.json');

    return json.decode(jsonString);
  }
}
