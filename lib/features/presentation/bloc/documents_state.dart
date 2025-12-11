import 'package:equatable/equatable.dart';
import 'package:horas_compl_app/features/domain/entities/documents_entity.dart';

class DocumentsState extends Equatable {
  final List<DocumentsEntity> documents;
  final bool isLoading;
  final String? error;

  const DocumentsState({
    this.documents = const [],
    this.isLoading = false,
    this.error,
  });

  DocumentsState copyWith({
    List<DocumentsEntity>? documents,
    bool? isLoading,
    String? error,
  }) {
    return DocumentsState(
      documents: documents ?? this.documents,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [documents, isLoading, error];
}
