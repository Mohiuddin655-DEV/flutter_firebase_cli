import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final String message;
  final String positionButtonText;
  final TextStyle positionButtonTextStyle;
  final String negativeButtonText;
  final TextStyle negativeButtonTextStyle;
  final void Function()? onPositive;
  final void Function()? onNegative;

  const ConfirmationDialog({
    super.key,
    this.message = "",
    this.positionButtonText = "OK",
    this.negativeButtonText = "Cancel",
    this.positionButtonTextStyle = const TextStyle(),
    this.negativeButtonTextStyle = const TextStyle(),
    this.onPositive,
    this.onNegative,
  });

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Text(
        widget.message,
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onNegative?.call();
            Navigator.pop(context);
          },
          child: Text(
            widget.negativeButtonText,
            style: widget.negativeButtonTextStyle,
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onPositive?.call();
            Navigator.pop(context);
          },
          child: Text(
            widget.positionButtonText,
            style: widget.positionButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
