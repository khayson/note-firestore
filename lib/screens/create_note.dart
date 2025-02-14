import 'package:flutter/material.dart';
import '../services/firestore.dart';
import '../utils/toast_helper.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController _noteController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;

  Future<void> _saveNote() async {
    if (_noteController.text.trim().isEmpty) {
      ToastHelper.showToast(context, 'Note cannot be empty', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _firestoreService.addNote(_noteController.text.trim());
      if (mounted) {
        ToastHelper.showToast(context, 'Note created successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showToast(
          context,
          'Failed to create note: ${e.toString()}',
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveNote,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _noteController,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Write your note here...',
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
      ),
    );
  }
}
