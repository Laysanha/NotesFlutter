import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  String title;
  String content;
  DateTime createDate;
  DateTime updateDate;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createDate,
    required this.updateDate,
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId,
      title: data['title'],
      content: data['content'],
      createDate: (data['createDate'] as Timestamp).toDate(),
      updateDate: (data['updateDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'title': title,
      'content': content,
      'createDate': Timestamp.fromDate(createDate),
      'updateDate': Timestamp.fromDate(updateDate),
    };
  }
}