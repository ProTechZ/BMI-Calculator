import 'package:flutter/material.dart';

class EntryDeletedSnackbar extends StatelessWidget {
  const EntryDeletedSnackbar({super.key, required this.onUndoAction});

  final void Function() onUndoAction;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: const SizedBox(
        height: 100,
        width: 100,
        child: Text('Deleted BMI Entry'),
      ),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: onUndoAction,
      ),
    );
  }
}
