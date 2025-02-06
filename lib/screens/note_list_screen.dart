import 'package:flutter/material.dart';
import 'package:notes_app_rec_arch/viewmodels/note_viewmodel.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: noteViewModel.notes.length,
        itemBuilder: (context, index) {
          final note = noteViewModel.notes[index];
          return Card(
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              trailing: IconButton(
                onPressed: () => noteViewModel.deleteNote(note.id),
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final titleController = TextEditingController();
              final contentController = TextEditingController();
              return AlertDialog(
                title: const Text('New Note'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(labelText: 'Content'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final title = titleController.text;
                      final content = contentController.text;
                      if (title.isNotEmpty && content.isNotEmpty) {
                        noteViewModel.addNote(title, content);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
