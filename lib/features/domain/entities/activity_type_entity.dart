import 'package:equatable/equatable.dart';

class ActivityType extends Equatable {
  final String name;
  final int individualHours;
  final int maximumHours;

  const ActivityType({
    required this.name,
    required this.individualHours,
    required this.maximumHours,
  });

  @override
  List<Object> get props => [name, individualHours, maximumHours];
}
