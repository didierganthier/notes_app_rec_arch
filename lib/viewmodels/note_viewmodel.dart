import 'package:flutter/material.dart';
import 'package:notes_app_rec_arch/models/note.dart';
import 'package:notes_app_rec_arch/repositories/note_repository.dart';

class NoteViewmodel extends ChangeNotifier {
  final NoteRepository _noteRepository;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  NoteViewmodel(this._noteRepository) {
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    _notes = await _noteRepository.getNotes();
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );
    await _noteRepository.addNote(newNote);
    fetchNotes();
  }

  Future<void> updateNote(Note note) async {
    await _noteRepository.updateNote(note);
    fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await _noteRepository.deleteNote(id);
    fetchNotes();
  }
}
