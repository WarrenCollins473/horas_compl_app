import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/core/di/injection_conatiner.dart';
import 'package:horas_compl_app/core/theme/app_theme.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_events.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_events.dart';
import 'package:horas_compl_app/features/presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DocumentsBloc>(
          create: (_) => getIt<DocumentsBloc>()..add(LoadDocumentsEvent()),
        ),
        BlocProvider<CurriculumRulesBloc>(
          create: (_) =>
              getIt<CurriculumRulesBloc>()..add(LoadCurriculumRules()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
