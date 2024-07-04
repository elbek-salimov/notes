abstract class NoteEvent {}

class AddNotesEvent extends NoteEvent {
  int? id;
  final String title;
  final String text;
  final DateTime time;

  AddNotesEvent({
    required this.title,
    required this.text,
    required this.time,
  });
}

class GetNotesEvent extends NoteEvent {}

class DeleteNoteEvent extends NoteEvent {
  final int noteId;

  DeleteNoteEvent({required this.noteId});
}

class UpdateNoteEvent extends NoteEvent {
  final int updateNoteId;
  final String title;
  final String text;
  final DateTime time;

  UpdateNoteEvent({
    required this.updateNoteId,
    required this.title,
    required this.text,
    required this.time,
  });
}

class SearchNoteEvent extends NoteEvent {
  final String searchText;

  SearchNoteEvent({required this.searchText});
}

