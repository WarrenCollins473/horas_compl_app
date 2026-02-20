import 'package:get_it/get_it.dart';
import 'package:horas_compl_app/core/database/isar_provider.dart';
import 'package:horas_compl_app/features/data/datasources/curriculum_local_datasouce_implamentation.dart';
import 'package:horas_compl_app/features/data/datasources/curriculum_local_datasource.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource.dart';
import 'package:horas_compl_app/features/data/datasources/documents_datasource_implementation.dart';
import 'package:horas_compl_app/features/data/repositories/curriculum_repository_implementation.dart';
import 'package:horas_compl_app/features/data/repositories/documents_repository_implementation.dart';
import 'package:horas_compl_app/features/domain/repositories/curriculum_rules_repository.dart';
import 'package:horas_compl_app/features/domain/repositories/documents_repository.dart';
import 'package:horas_compl_app/features/domain/usecases/add_documents_usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/delete_documents_usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/get_curriculum_rules.dart';
import 'package:horas_compl_app/features/domain/usecases/get_documents_usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/update_documents_usecase.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:isar_community/isar.dart';

// Curriculum Rules

final getIt = GetIt.instance;

Future<void> init() async {
  // --------- BLoC ---------
  getIt.registerFactory(() => CurriculumRulesBloc(getIt()));
  getIt.registerFactory(
    () => DocumentsBloc(
      getDocumentsUsecase: getIt(),
      addDocumentsUsecase: getIt(),
      deleteDocumentsUsecase: getIt(),
      updateDocumentsUsecase: getIt(),
    ),
  );

  // --------- Use cases ---------
  getIt.registerLazySingleton(() => GetCurriculumRules(getIt()));
  getIt.registerLazySingleton(() => GetDocumentsUsecase(getIt()));
  getIt.registerLazySingleton(() => AddDocumentsUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteDocumentsUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateDocumentsUsecase(getIt()));

  // --------- Repository ---------
  getIt.registerLazySingleton<CurriculumRepository>(
    () => CurriculumRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<IDocumentsRepository>(
    () => DocumentsRepositoryImplementation(datasource: getIt()),
  );

  // --------- Data sources ---------
  getIt.registerLazySingleton<CurriculumLocalDatasource>(
    () => CurriculumLocalDatasourceImpl(),
  );
  getIt.registerLazySingleton<IDocumentsDatasource>(
    () => DocumentsDatasourceImplementation(db: getIt()),
  );

  final isar = await IsarProvider.open();
  getIt.registerSingleton<Isar>(isar);
}
