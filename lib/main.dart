import 'package:flutter/material.dart';
import 'package:notes/features/notes/view/pages/notes_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      home: const NotesPage(),
    );
  }
}
