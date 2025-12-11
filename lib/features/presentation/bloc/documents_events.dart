import 'package:equatable/equatable.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

abstract class DocumentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDocumentsEvent extends DocumentsEvent {}

class AddDocumentEvent extends DocumentsEvent {
  final DocumentsEntity document;
  AddDocumentEvent(this.document);

  @override
  List<Object?> get props => [document];
}

class UpdateDocumentEvent extends DocumentsEvent {
  final DocumentsEntity document;
  UpdateDocumentEvent(this.document);

  @override
  List<Object?> get props => [document];
}

class DeleteDocumentEvent extends DocumentsEvent {
  final int id;
  DeleteDocumentEvent(this.id);

  @override
  List<Object?> get props => [id];
}
