import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_state.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_events.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_state.dart';
import 'package:horas_compl_app/features/presentation/components/action_button.dart';
import 'package:horas_compl_app/features/presentation/components/activity_hours_info.dart';
import 'package:horas_compl_app/features/presentation/components/custom_dropdown.dart';
import 'package:horas_compl_app/features/presentation/components/hours_input.dart';
import 'package:horas_compl_app/features/presentation/components/detailTitle.dart';

class DetailsPage extends StatefulWidget {
  final int? id;

  const DetailsPage({super.key, this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _observationController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String? selectedActivity;
  String? selectedType;
  int individualHours = 0;
  int maximumHours = 0;
  int? obtainedHours;

  @override
  void initState() {
    super.initState();
    loadDocumentDetails();
  }

  void loadDocumentDetails() {
    if (widget.id != null) {
      final document = context.read<DocumentsBloc>().state.documents.firstWhere(
        (d) => d.id == widget.id,
      );
      setState(() {
        selectedCategory = document.category;
        _categoryController.text = document.category;
        selectedActivity = document.activity;
        _activityController.text = document.activity;
        selectedType = document.type;
        if (document.type != null) {
          _typeController.text = document.type!;
        } else {
          _typeController.clear();
        }
        _observationController.text = document.observation;
        _linkController.text = document.link;
        obtainedHours = document.hours;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _validateAndSave() {
    if (selectedCategory == null) {
      _showMessage("Selecione uma categoria");
      return;
    }

    if (selectedActivity == null) {
      _showMessage("Selecione uma atividade");
      return;
    }
    if (context
                .read<CurriculumRulesBloc>()
                .state
                .rules!
                .categories
                .firstWhere((c) => c.name == selectedCategory)
                .activities
                .firstWhere((a) => a.name == selectedActivity)
                .types !=
            null &&
        selectedType == null) {
      _showMessage("Selecione um tipo");
      return;
    }

    if (obtainedHours == null || obtainedHours == 0) {
      _showMessage("Informe a carga horária");
      return;
    }

    if (_linkController.text.isEmpty) {
      _showMessage("Informe o link do certificado");
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    context.read<DocumentsBloc>().add(
      widget.id == null
          ? AddDocumentEvent(
              DocumentsEntity(
                id: DateTime.now().millisecondsSinceEpoch,
                category: selectedCategory!,
                activity: selectedActivity!,
                type: selectedType,
                hours: obtainedHours!,
                observation: _observationController.text,
                link: _linkController.text,
              ),
            )
          : UpdateDocumentEvent(
              DocumentsEntity(
                id: widget.id!,
                category: selectedCategory!,
                activity: selectedActivity!,
                type: selectedType,
                hours: obtainedHours!,
                observation: _observationController.text,
                link: _linkController.text,
              ),
            ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do documento',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, documentsState) {
          return BlocBuilder<CurriculumRulesBloc, CurriculumRulesState>(
            builder: (context, curriculumRulesState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailTitle(text: "Categoria"),
                      CustomDropdown(
                        hintText: "Selecione a categoria",
                        controller: _categoryController,
                        entries: curriculumRulesState.rules!.categories
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e.name,
                                label: e.name,
                              ),
                            )
                            .toList(),
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value;
                            _activityController.clear();
                            selectedActivity = null;
                            selectedType = null;
                            _typeController.clear();
                          });
                        },
                      ),
                      DetailTitle(text: "Atividade"),
                      CustomDropdown(
                        hintText: "Selecione a atividade",
                        controller: _activityController,
                        enabled: selectedCategory != null,
                        entries: selectedCategory == null
                            ? []
                            : curriculumRulesState.rules!.categories
                                  .firstWhere((c) => c.name == selectedCategory)
                                  .activities
                                  .map(
                                    (e) => DropdownMenuEntry(
                                      value: e.name,
                                      label: e.name,
                                    ),
                                  )
                                  .toList(),
                        onSelected: (value) {
                          setState(() {
                            selectedActivity = value;
                            selectedType = null;
                            _typeController.clear();
                          });
                        },
                      ),
                      DetailTitle(text: "Tipo"),
                      CustomDropdown(
                        hintText: "Selecione o tipo",
                        controller: _typeController,
                        enabled:
                            selectedActivity != null &&
                            curriculumRulesState.rules!.categories
                                    .firstWhere(
                                      (c) => c.name == selectedCategory,
                                    )
                                    .activities
                                    .firstWhere(
                                      (a) => a.name == selectedActivity,
                                    )
                                    .types !=
                                null,
                        entries: selectedActivity == null
                            ? []
                            : curriculumRulesState.rules!.categories
                                      .firstWhere(
                                        (c) => c.name == selectedCategory,
                                      )
                                      .activities
                                      .firstWhere(
                                        (a) => a.name == selectedActivity,
                                      )
                                      .types
                                      ?.map(
                                        (e) => DropdownMenuEntry(
                                          value: e.name,
                                          label: e.name,
                                        ),
                                      )
                                      .toList() ??
                                  [],
                        onSelected: (value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                color: Color(0xFFEDEDED),
                              ),
                              child: Center(
                                child: Text(
                                  'Carga Horária',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                            const Divider(height: 1),

                            ActivityHoursInfo(
                              selectedCategory: selectedCategory,
                              selectedActivity: selectedActivity,
                              selectedType: selectedType,
                              curriculumRulesState: curriculumRulesState,
                              onHoursChanged: (individual, maximum) {
                                individualHours = individual;
                                maximumHours = maximum;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      HoursInput(
                        individualHours: individualHours,
                        maximumHours: maximumHours,
                        obtainedHours: obtainedHours ?? 0,
                        onHoursCalculated: (value) {
                          setState(() {
                            obtainedHours = value;
                          });
                        },
                      ),
                      DetailTitle(text: "Observação"),
                      TextField(
                        maxLines: 3,
                        controller: _observationController,
                        decoration: InputDecoration(
                          hintText: "Digite uma observação (opcional)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      DetailTitle(text: "Link"),
                      TextFormField(
                        controller: _linkController,

                        decoration: InputDecoration(
                          hintText: "Digite o link",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ActionButton(
                        text: "Salvar",
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () {
                          _validateAndSave();
                        },
                      ),
                      if (widget.id != null) ...[
                        const SizedBox(height: 12),
                        ActionButton(
                          text: "Excluir",
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Excluir documento"),
                                content: const Text(
                                  "Deseja realmente excluir este documento?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancelar",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<DocumentsBloc>().add(
                                        DeleteDocumentEvent(widget.id!),
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Excluir",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ],
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
