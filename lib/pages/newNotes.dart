import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_flutter/constants/app_styles.dart';
import 'package:notes_flutter/models/note.dart';

class NewNotes extends StatefulWidget {
  const NewNotes({super.key});

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _showLabel = true;

  void _removeLabel() {
    setState(() {
      _showLabel = false;
    });
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      Note newNotes = Note(
        title: _titleController.text,
        content: _contentController.text,
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      //Add no Firebase
      await FirebaseFirestore.instance
          .collection('notes')
          .add(newNotes.toMap());
      _titleController.clear();
      _contentController.clear();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor! Preencha os campos!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Voltar'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 50,
              height: 50,
              child: TextButton(
                onPressed: _saveNote,
                style: TextButton.styleFrom(
                  backgroundColor: ColorStyle.lightSkyBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(
                  CupertinoIcons.tray_arrow_up,
                  color: ColorStyle.primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: InputBorder.none,
                  labelText: 'Título',
                  labelStyle: TextStyle(
                      fontSize: FontSizeStyle.title,
                      fontWeight: FontWeight.bold,
                      color: ColorStyle.primaryBlack)),
              style: const TextStyle(
                fontSize: FontSizeStyle.large,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 14,
              decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  alignLabelWithHint: true,
                  border: InputBorder.none,
                  labelText: 'Digite algo...',
                  labelStyle: TextStyle(
                      fontSize: FontSizeStyle.large,
                      fontWeight: FontWeight.normal,
                      color: ColorStyle.primaryBlack)),
              style: const TextStyle(
                fontSize: FontSizeStyle.large,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
