import 'package:go_router/go_router.dart';
import 'package:notes_app_rec_arch/screens/note_list_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NoteListScreen(),
    ),
  ],
);
