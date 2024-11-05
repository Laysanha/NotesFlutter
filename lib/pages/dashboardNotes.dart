import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_flutter/constants/app_styles.dart';
import 'package:notes_flutter/pages/newNotes.dart';

class DashboardNotes extends StatefulWidget {
  const DashboardNotes({super.key});

  @override
  State<DashboardNotes> createState() => _DashboardNotesState();
}

class _DashboardNotesState extends State<DashboardNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(
                fontSize: FontSizeStyle.title, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: TextButton(
                  onPressed: () => {},
                  style: TextButton.styleFrom(
                    backgroundColor: ColorStyle.lightSkyBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.search,
                    color: ColorStyle.primaryBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: const Center(),
        floatingActionButton: SizedBox(
          width: 75,
          height: 75,
          child: FloatingActionButton(
            backgroundColor: ColorStyle.primaryBlack,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewNotes(),
                  ));
            },
            shape: const CircleBorder(),
            child: const Icon(
              CupertinoIcons.plus,
              size: 32,
              color: ColorStyle.lightGray,
            ),
          ),
        ));
  }
}
