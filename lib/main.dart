import 'package:flutter/material.dart';
import 'package:notes_app_rec_arch/repositories/note_repository.dart';
import 'package:notes_app_rec_arch/routes/routes.dart';
import 'package:notes_app_rec_arch/screens/note_list_screen.dart';
import 'package:notes_app_rec_arch/viewmodels/note_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => NoteRepository()),
        ChangeNotifierProvider(
          create: (context) => NoteViewmodel(context.read<NoteRepository>()),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
