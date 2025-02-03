import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_viewmodel.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel()..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Users')),
        body: Consumer<UserViewModel>(
          builder: (context, vm, _) => ListView.builder(
            itemCount: vm.users.length,
            itemBuilder: (context, index) {
              final user = vm.users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => vm.deleteUser(user.id),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Provider.of<UserViewModel>(context, listen: false)
              .addUser("New User", "new@example.com"),
        ),
      ),
    );
  }
}
