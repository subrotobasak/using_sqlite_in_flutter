import 'dart:math';

import 'package:flutter/material.dart';
import 'package:using_sqlite_in_flutter/model/note_model.dart';
import 'package:using_sqlite_in_flutter/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;

  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    if (note != null) {
      titleController.text = note!.title;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'Write Something...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Note Title',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.75),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,

                child: MaterialButton(
                  height: 45,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  onPressed: () async {
                    final title = titleController.value.text;
                    if (title.isEmpty) {
                      return;
                    } else {
                      final Note model = Note(id: note?.id, title: title);
                      if (note == null) {
                        await DatabaseHelper.addNote(model);
                      } else {
                        await DatabaseHelper.updateNote(model);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    note == null ? 'Save' : 'Update',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
