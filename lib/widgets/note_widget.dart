import 'dart:math';

import 'package:flutter/material.dart';
import 'package:using_sqlite_in_flutter/model/note_model.dart';


class NoteWidget extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const NoteWidget(
      {Key? key,
      required this.note,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              note.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
