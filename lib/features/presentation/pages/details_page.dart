import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_state.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_bloc.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_state.dart';
import 'package:horas_compl_app/features/presentation/widgets/title.dart';

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
  final TextEditingController _hoursController = TextEditingController();

  String? selectedCategory;
  String? selectedActivity;
  String? selectedType;
  int hoursIndividual = 0;
  int hoursMax = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do documento')),
      body: BlocBuilder<DocumentsBloc, DocumentsState>(
        builder: (context, documentsState) {
          return BlocBuilder<CurriculumRulesBloc, CurriculumRulesState>(
            builder: (context, curriculumRulesState) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailTitle(text: "Categoria"),
                    DropdownMenu(
                      hintText: "Selecione a categoria",
                      menuStyle: MenuStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      ),
                      controller: _categoryController,
                      dropdownMenuEntries: curriculumRulesState
                          .rules!
                          .categories
                          .map(
                            (e) =>
                                DropdownMenuEntry(value: e.name, label: e.name),
                          )
                          .toList(),

                      expandedInsets: EdgeInsets.zero,
                      onSelected: (String? value) {
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
                    if (selectedCategory != null)
                      DropdownMenu(
                        hintText: "Selecione a atividade",
                        controller: _activityController,
                        menuStyle: MenuStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                        ),
                        dropdownMenuEntries: curriculumRulesState
                            .rules!
                            .categories
                            .firstWhere(
                              (category) => category.name == selectedCategory,
                            )
                            .activities
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e.name,
                                label: e.name,
                              ),
                            )
                            .toList(),

                        expandedInsets: EdgeInsets.zero,
                        onSelected: (String? value) {
                          setState(() {
                            selectedActivity = value;
                            selectedType = null;
                            _typeController.clear();
                          });
                        },
                      )
                    else
                      DropdownMenu(
                        hintText: "Selecione a atividade",
                        enabled: false,
                        expandedInsets: EdgeInsets.zero,
                        onSelected: (value) {},
                        dropdownMenuEntries: [],
                      ),
                    DetailTitle(text: "Tipo"),
                    if (selectedActivity != null &&
                        curriculumRulesState.rules!.categories
                                .firstWhere(
                                  (category) =>
                                      category.name == selectedCategory,
                                )
                                .activities
                                .firstWhere(
                                  (activity) =>
                                      activity.name == selectedActivity,
                                )
                                .types !=
                            null)
                      DropdownMenu(
                        hintText: "Selecione o tipo",
                        controller: _typeController,
                        menuStyle: MenuStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                        ),
                        dropdownMenuEntries: curriculumRulesState
                            .rules!
                            .categories
                            .firstWhere(
                              (category) => category.name == selectedCategory,
                            )
                            .activities
                            .firstWhere(
                              (activity) => activity.name == selectedActivity,
                            )
                            .types!
                            .map(
                              (e) => DropdownMenuEntry(
                                value: e.name,
                                label: e.name,
                              ),
                            )
                            .toList(),

                        expandedInsets: EdgeInsets.zero,
                        onSelected: (String? value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                      )
                    else
                      DropdownMenu(
                        hintText: "Selecione o tipo",
                        enabled: false,
                        expandedInsets: EdgeInsets.zero,
                        onSelected: (value) {},
                        dropdownMenuEntries: [],
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
                            child: const Center(
                              child: Text(
                                'Carga Horária',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Divider(height: 1),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text(
                                      'Individual',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'Máxima',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '0',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      '0',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Horas lançadas
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Horas lançadas',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                controller: _hoursController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  // Update the hours value in the state or perform any necessary action
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Horas obtidas
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Horas obtidas',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text('0', style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
