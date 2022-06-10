import 'package:flutter/material.dart';
import 'package:using_sqlite_in_flutter/screens/notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqlite in Flutter',
      home: NoteScreens(),
    );
  }
}
