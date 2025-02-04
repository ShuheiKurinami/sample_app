import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_viewmodel.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({Key? key}) : super(key: key);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value ?? '',
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Please enter a name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value ?? '',
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Please enter an email' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              Provider.of<UserViewModel>(context, listen: false)
                  .addUser(_name, _email);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
