import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/presentation/app_routes.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_state.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_state.dart';
import 'package:horas_compl_app/features/presentation/pages/details_page.dart';
import 'package:horas_compl_app/features/presentation/widgets/document_card.dart';
import 'package:horas_compl_app/features/presentation/widgets/drawer.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus documentos')),
      drawer: AppDrawer(currentRoute: AppRoutes.documents.path),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, documentsState) {
          return BlocBuilder<CurriculumRulesBloc, CurriculumRulesState>(
            builder: (context, curriculumRulesState) {
              if (documentsState.documents.isEmpty) {
                return Center(child: Text("Nenhum documento adicionado"));
              } else {
                return ListView.builder(
                  itemCount: documentsState.documents.length,
                  itemBuilder: (context, index) {
                    final item = documentsState.documents[index];

                    return DocumentCard(
                      document: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailsPage(),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
