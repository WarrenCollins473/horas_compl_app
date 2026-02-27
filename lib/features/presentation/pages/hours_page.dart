import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/presentation/app_routes.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_state.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_state.dart';
import 'package:horas_compl_app/features/presentation/widgets/category_bar.dart';
import 'package:horas_compl_app/features/presentation/widgets/drawer.dart';
import 'package:horas_compl_app/features/presentation/widgets/total_bar.dart';

class HoursPage extends StatelessWidget {
  const HoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas horas')),
      drawer: AppDrawer(currentRoute: AppRoutes.hours.path),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, documentsState) {
          return BlocBuilder<CurriculumRulesBloc, CurriculumRulesState>(
            builder: (context, curriculumRulesState) {
              if (documentsState.isLoading ||
                  curriculumRulesState.isLoading ||
                  curriculumRulesState.rules == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final totalHours = documentsState.documents.fold(
                  0,
                  (sum, doc) => sum + doc.hours,
                );

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TotalBar(
                        current: totalHours,
                        title: 'Total de Horas',
                        total: curriculumRulesState.rules!.minimumTotalHours,
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: 1,
                        color: Colors.grey[850],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: const Text(
                          'Por categoria',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Column(
                        children: curriculumRulesState.rules!.categories.map((
                          category,
                        ) {
                          final categoryHours = documentsState.documents
                              .where((doc) => doc.category == category.name)
                              .fold(0, (sum, doc) => sum + doc.hours);

                          return CategoryBar(
                            current: categoryHours,
                            title: category.name,
                            total: category.categoryLimit,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
