import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_viewmodel.dart';
import 'add_user_dialog.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListView.builder(
        itemCount: vm.users.length,
        itemBuilder: (context, index) {
          final user = vm.users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => vm.deleteUser(user.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddUserDialog(),
          );
        },
      ),
    );
  }
}
