import 'package:flutter/material.dart';

class NoteUpdateDialog extends StatefulWidget {
  final String? initialText;
  final String hint;
  final void Function()? onCancel;
  final void Function(String value) onUpdate;

  const NoteUpdateDialog({
    super.key,
    this.initialText,
    this.hint = "",
    this.onCancel,
    required this.onUpdate,
  });

  @override
  State<NoteUpdateDialog> createState() => _NoteUpdateDialogState();
}

class _NoteUpdateDialogState extends State<NoteUpdateDialog> {
  late TextEditingController editor;

  @override
  void initState() {
    editor = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: TextField(
        controller: editor,
        decoration: InputDecoration(
          hintText: widget.hint,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancel?.call();
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onUpdate(editor.text);
            Navigator.pop(context);
          },
          child: const Text(
            "Update",
          ),
        ),
      ],
    );
  }
}
