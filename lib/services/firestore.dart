import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection("notes");

  //CREATE: add a new note
  Future<void> addNote(String note) async {
    try {
      await notes.add({
        "note": note,
        "timestamp": Timestamp.now(),
      });
    } catch (e) {
      print('Error adding note: $e');
      throw Exception('Failed to add note: $e');
    }
  }

  //READ: get all notes from database
  Stream<QuerySnapshot> getNotes() {
    final notesStream = 
    notes.orderBy("timestamp", descending: true).snapshots();
    
    return notesStream;
  }

  //UPDATE: update a note given a doc id
  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update({
      "note": newNote,
      "timestamp": Timestamp.now(),
    });
  }

  //DELETE: delete a note given a doc id
  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }
}
