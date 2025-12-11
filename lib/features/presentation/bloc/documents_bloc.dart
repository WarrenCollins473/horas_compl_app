import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horas_compl_app/core/usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/add_documents_usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/delete_documents_usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/get_documents_usecase.dart';
import 'package:horas_compl_app/features/domain/usecases/update_documents_usecase.dart';
import 'package:horas_compl_app/features/presentation/bloc/documents_events.dart';
import 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final GetDocumentsUsecase getDocumentsUsecase;
  final AddDocumentsUsecase addDocumentsUsecase;
  final DeleteDocumentsUsecase deleteDocumentsUsecase;
  final UpdateDocumentsUsecase updateDocumentsUsecase;

  DocumentsBloc({
    required this.getDocumentsUsecase,
    required this.addDocumentsUsecase,
    required this.deleteDocumentsUsecase,
    required this.updateDocumentsUsecase,
  }) : super(const DocumentsState()) {
    on<LoadDocumentsEvent>(_loadDocuments);
    on<AddDocumentEvent>(_addDocument);
    on<UpdateDocumentEvent>(_updateDocument);
    on<DeleteDocumentEvent>(_deleteDocument);
  }

  Future<void> _loadDocuments(
    LoadDocumentsEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getDocumentsUsecase(NoParams());
    emit(
      result.fold(
        (failure) =>
            state.copyWith(isLoading: false, error: 'Failed to load documents'),
        (docs) => state.copyWith(isLoading: false, documents: docs),
      ),
    );
  }

  Future<void> _addDocument(
    AddDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    await addDocumentsUsecase(event.document);
    add(LoadDocumentsEvent());
  }

  Future<void> _updateDocument(
    UpdateDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    await updateDocumentsUsecase(event.document);
    add(LoadDocumentsEvent());
  }

  Future<void> _deleteDocument(
    DeleteDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    await deleteDocumentsUsecase(event.id);
    add(LoadDocumentsEvent());
  }
}
