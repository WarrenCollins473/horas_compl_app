import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/presentation/app_routes.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_state.dart';
import 'package:horas_compl_app/features/presentation/components/drawer.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_state.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  static Future<Uint8List> generatePdf(
    DocumentsState documentState,
    CurriculumRulesState rulesState,
  ) async {
    final pdf = pw.Document();

    final headers = [
      "Categoria",
      "Atividade",
      "Tipo",
      "Horas",
      "Observação",
      "Link",
    ];

    final data = documentState.documents.map((doc) {
      return [
        doc.category,
        doc.activity,
        doc.type ?? "",
        doc.hours.toString(),
        doc.observation,
        doc.link,
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(25),
        build: (context) {
          return [
            pw.Text(
              "Relatório de Horas Complementares",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              "Total de horas: ${documentState.documents.fold<int>(0, (sum, doc) => sum + doc.hours)}/${rulesState.rules!.minimumTotalHours}",
              style: pw.TextStyle(fontSize: 16),
            ),

            pw.SizedBox(height: 10),

            ...rulesState.rules!.categories.map((category) {
              final totalHours = documentState.documents
                  .where((doc) => doc.category == category.name)
                  .fold<int>(0, (sum, doc) => sum + doc.hours);

              return pw.Text(
                "${category.name}: $totalHours/${category.categoryLimit}",
              );
            }),

            pw.SizedBox(height: 20),

            pw.Text(
              "Documentos",
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 10),

            pw.TableHelper.fromTextArray(
              headers: headers,
              data: data,
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellStyle: pw.TextStyle(fontSize: 10),
              columnWidths: {
                0: const pw.FixedColumnWidth(70),
                1: const pw.FixedColumnWidth(110),
                2: const pw.FixedColumnWidth(60),
                3: const pw.FixedColumnWidth(40),
                4: const pw.FixedColumnWidth(110),
                5: const pw.FlexColumnWidth(),
              },
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static void previewPdf(
    BuildContext context,
    DocumentsState documentState,
    CurriculumRulesState rulesState,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreview(
          build: (format) => generatePdf(documentState, rulesState),
          allowPrinting: false,
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerar PDF',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      drawer: AppDrawer(currentRoute: AppRoutes.pdf.path),

      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, documentState) {
          return BlocBuilder<CurriculumRulesBloc, CurriculumRulesState>(
            builder: (context, rulesState) {
              return Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    previewPdf(context, documentState, rulesState);
                  },
                  child: Text(
                    "Visualizar PDF",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
