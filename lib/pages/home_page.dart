import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  Firebase Firestore instance
  final FirestoreService firestoreService = FirestoreService();

  // Text editing controller for the note
  final TextEditingController textController = TextEditingController();

  //  open a dialog box to add a new note
  void openNoteBox({String? docId}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Note"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add the note to the database
              if (docId == null) {
                firestoreService.addNote(textController.text);
              } 
              // Add the note to the database
              else {
                firestoreService.updateNote(docId, textController.text);
              }

              // Clear the text controller
              textController.clear();

              // Close the dialog box
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get each individual note
                DocumentSnapshot document = notesList[index];
                String docId = document.id;

                // get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data["note"];

                // display as a list tile
                return ListTile(
                  title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // edit the note
                        IconButton(onPressed: () => openNoteBox(docId: docId), 
                        icon: Icon(Icons.settings)),
                        // delete the note
                        IconButton(onPressed: () => firestoreService.deleteNote(docId), 
                        icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
              },
            );
          }
          
          // if there is no notes
          else {
            return const Center(child: Text("No notes found"));
          }
        },
      ),
    );
  }
}

