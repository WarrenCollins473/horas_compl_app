import 'package:equatable/equatable.dart';

class DocumentsEntity extends Equatable {
  final int id;
  final String category;
  final String activity;
  final String type;
  final String observation;
  final int hours;
  final String link;

  const DocumentsEntity({
    required this.id,
    required this.category,
    required this.activity,
    required this.type,
    required this.observation,
    required this.hours,
    required this.link,
  });

  @override
  List<Object?> get props => [
    id,
    category,
    activity,
    type,
    observation,
    hours,
    link,
  ];
}
