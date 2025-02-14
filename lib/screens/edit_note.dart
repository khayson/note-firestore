import 'package:flutter/material.dart';
import '../services/firestore.dart';
import '../utils/toast_helper.dart';

class EditNote extends StatefulWidget {
  final String docId;
  final String initialNote;

  const EditNote({
    super.key,
    required this.docId,
    required this.initialNote,
  });

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController _noteController;
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
    _noteController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _hasChanges = _noteController.text != widget.initialNote;
    });
  }

  Future<void> _updateNote() async {
    if (_noteController.text.trim().isEmpty) {
      ToastHelper.showToast(context, 'Note cannot be empty', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _firestoreService.updateNote(
        widget.docId,
        _noteController.text.trim(),
      );
      if (mounted) {
        ToastHelper.showToast(context, 'Note updated successfully');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showToast(
          context,
          'Failed to update note: ${e.toString()}',
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
    _noteController.removeListener(_onTextChanged);
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
          else if (_hasChanges)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _updateNote,
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
        ),
      ),
    );
  }
}
