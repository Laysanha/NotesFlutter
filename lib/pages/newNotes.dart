import 'package:flutter/material.dart';
import 'package:notes_flutter/models/note.dart';

class NewNotes extends StatefulWidget {
  const NewNotes({super.key});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future<void> _saveNote() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Note newNotes = Note(
        title: _titleController.text,
        content: _contentController.text,
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      //Add no Firebase

    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("LAYSA LINDONA"),
      ),
    );
  }
}
