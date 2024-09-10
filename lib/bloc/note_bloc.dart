import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/local/local_database.dart';
import '../data/models/note_model.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NotesInitialState()) {
    on<GetNotesEvent>(_getNotes);
    on<AddNotesEvent>(_insertNotes);
    on<UpdateNoteEvent>(_updateNote);
    on<DeleteNoteEvent>(_deleteNote);
    on<SearchNoteEvent>(_searchNote);
  }

  Future<void> _insertNotes(
    AddNotesEvent event,
    Emitter<NoteState> emit,
  ) async {
    LocalDatabase.insertNote(
        NoteModel(title: event.title, text: event.text, time: event.time));
    add(GetNotesEvent());
  }

  Future<void> _updateNote(
    UpdateNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    LocalDatabase.updateNote(
        NoteModel(title: event.title, text: event.text, time: event.time),
        event.updateNoteId);
    add(GetNotesEvent());
  }

  Future<void> _getNotes(
      GetNotesEvent event,
      Emitter<NoteState> emit
      ) async {
    emit(NotesLoadingState());
    try {
      final notes = await LocalDatabase.getAllNotes();
      emit(NotesSuccessState(notes: notes));
    } catch (error) {
      emit(NotesErrorState(errorText: error.toString()));
    }
  }


  Future<void> _deleteNote(
    DeleteNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    await LocalDatabase.deleteNote(event.noteId);
    emit(NotesDeleteState());
    add(GetNotesEvent());
  }

  Future<void> _searchNote(
    SearchNoteEvent event,
    Emitter<NoteState> emit,
  ) async {
    try {
      final notes = await LocalDatabase.searchNote(event.searchText);
      emit(NotesSuccessState(notes: notes));
    } catch (error) {
      emit(NotesErrorState(errorText: error.toString()));
    }
  }
}
