import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.msg, {super.key});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Invalid Content',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(msg, style: Theme.of(context).textTheme.bodySmall),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Okay'),
        )
      ],
    );
  }
}
