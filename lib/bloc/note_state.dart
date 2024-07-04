import '../data/models/note_model.dart';

abstract class NoteState {}

class NotesInitialState extends NoteState {}

class NotesLoadingState extends NoteState {}

class NotesSuccessState extends NoteState {
  NotesSuccessState({required this.notes});

  final List<NoteModel> notes;
}

class NotesErrorState extends NoteState {
  NotesErrorState({required this.errorText});

  final String errorText;
}

class NotesDeleteState extends NoteState {}
