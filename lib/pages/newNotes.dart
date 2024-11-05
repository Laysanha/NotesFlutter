import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  Future<void> _showConfirmeDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorStyle.primaryBlack,
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: ColorStyle.statusOrange,
              ),
              SizedBox(width: 8),
              Text(
                'Deseja salvar a nota?',
                style: TextStyle(
                  color: ColorStyle.lightSkyBlue,
                  fontSize: FontSizeStyle.large,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveNote();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorStyle.primaryBlue),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Salvar',
                style: TextStyle(
                  color: ColorStyle.lightSkyBlue,
                  fontSize: FontSizeStyle.medium,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyle.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: ColorStyle.lightSkyBlue,
                  fontSize: FontSizeStyle.medium,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResultDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK')),
          ],
        );
      },
    );
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
        const SnackBar(
          content: Text('Por favor! Preencha os campos!'),
        ),
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
                onPressed: _showConfirmeDialog,
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _titleController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      labelText: 'Título',
                      labelStyle: TextStyle(
                          fontSize: FontSizeStyle.title,
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.primaryBlack)),
                  style: const TextStyle(
                    fontSize: FontSizeStyle.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
