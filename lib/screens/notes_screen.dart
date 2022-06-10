import 'dart:math';

import 'package:flutter/material.dart';
import 'package:using_sqlite_in_flutter/model/note_model.dart';
import 'package:using_sqlite_in_flutter/screens/note_screen.dart';
import 'package:using_sqlite_in_flutter/services/database_helper.dart';

import '../widgets/note_widget.dart';

class NoteScreens extends StatefulWidget {
  const NoteScreens({Key? key}) : super(key: key);

  @override
  State<NoteScreens> createState() => _NoteScreensState();
}

class _NoteScreensState extends State<NoteScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteScreen()));
          setState(() {});
        },
        backgroundColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>?>(
          future: DatabaseHelper.getAllNote(),
          builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                value: 100,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => NoteWidget(
                    note: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteScreen(
                                    note: snapshot.data![index],
                                  )));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to delete this note?'),
                              actions: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    await DatabaseHelper.deleteNote(
                                        snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
            }
            return const Center(
              child: Text('No notes yet'),
            );
          }),
    );
  }
}
