import 'package:equatable/equatable.dart';

class DocumentsEntity extends Equatable {
  int id;
  String category;
  String activity;
  String type;
  String observation;
  int hours;
  String link;

  DocumentsEntity({
    required this.id,
    required this.category,
    required this.activity,
    required this.type,
    required this.observation,
    required this.hours,
    required this.link,
  });

  @override
  // TODO: implement props
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
