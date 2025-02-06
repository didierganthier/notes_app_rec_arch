import 'package:flutter/material.dart';
import 'package:notes_app_rec_arch/viewmodels/note_viewmodel.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewmodel>(context);
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('Notes', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: noteViewModel.notes.length,
        itemBuilder: (context, index) {
          final note = noteViewModel.notes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.pink[50],
              child: ListTile(
                title: Text(
                  note.title,
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  note.content,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: IconButton(
                  onPressed: () => noteViewModel.deleteNote(note.id),
                  icon: const Icon(Icons.delete, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[200],
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Title and content cannot be empty'),
                          ),
                        );
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
