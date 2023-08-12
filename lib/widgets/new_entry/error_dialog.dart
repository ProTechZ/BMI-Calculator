import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.msg, {super.key});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Invalid Content',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
      content: Text(msg, style: const TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Okay', style: TextStyle(fontSize: 16)),
        )
      ],
    );
  }
}
