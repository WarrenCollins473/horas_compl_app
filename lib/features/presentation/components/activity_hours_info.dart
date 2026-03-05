import 'package:flutter/material.dart';
import 'package:horas_compl_app/features/presentation/bloc/curriculum_rules_state.dart';

class ActivityHoursInfo extends StatelessWidget {
  final String? selectedCategory;
  final String? selectedActivity;
  final String? selectedType;
  final CurriculumRulesState curriculumRulesState;

  final Function(int individual, int maximum)? onHoursChanged;

  const ActivityHoursInfo({
    super.key,
    required this.selectedCategory,
    required this.selectedActivity,
    required this.selectedType,
    required this.curriculumRulesState,
    this.onHoursChanged,
  });

  int _getIndividualHours() {
    if (selectedCategory == null || selectedActivity == null) return 0;

    final category = curriculumRulesState.rules!.categories.firstWhere(
      (c) => c.name == selectedCategory,
    );

    final activity = category.activities.firstWhere(
      (a) => a.name == selectedActivity,
    );

    if (activity.types == null || activity.types!.isEmpty) {
      return activity.individualHours ?? 0;
    }

    if (selectedType == null) return 0;

    final type = activity.types!.firstWhere((t) => t.name == selectedType);

    return type.individualHours;
  }

  int _getMaximumHours() {
    if (selectedCategory == null || selectedActivity == null) return 0;

    final category = curriculumRulesState.rules!.categories.firstWhere(
      (c) => c.name == selectedCategory,
    );

    final activity = category.activities.firstWhere(
      (a) => a.name == selectedActivity,
    );

    if (activity.types == null || activity.types!.isEmpty) {
      return activity.maximumHours ?? 0;
    }

    if (selectedType == null) return 0;

    final type = activity.types!.firstWhere((t) => t.name == selectedType);

    return type.maximumHours;
  }

  @override
  Widget build(BuildContext context) {
    final individual = _getIndividualHours();
    final maximum = _getMaximumHours();

    onHoursChanged?.call(individual, maximum);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                'Individual',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              Text(
                'Máxima',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(individual.toString(), style: const TextStyle(fontSize: 15)),
              Text(maximum.toString(), style: const TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
