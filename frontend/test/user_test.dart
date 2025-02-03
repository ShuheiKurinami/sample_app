import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/user.dart';
import 'package:frontend/viewmodels/user_viewmodel.dart';

void main() {
  group('UserRepository', () {
    final repo = UserRepository();

    test('create and list', () async {
      final user = await repo.createUser(
        User(id: 0, name: "Test", email: "test@example.com"),
      );
      final list = await repo.listUsers();
      expect(list.contains(user), true);
    });

    test('update', () async {
      final user = await repo.createUser(
        User(id: 0, name: "Old", email: "old@example.com"),
      );
      final updated = await repo.updateUser(
        User(id: user.id, name: "New", email: "new@example.com"),
      );
      expect(updated.name, "New");
    });

    test('delete', () async {
      final user = await repo.createUser(
        User(id: 0, name: "Delete", email: "delete@example.com"),
      );
      await repo.deleteUser(user.id);
      final list = await repo.listUsers();
      expect(list.any((u) => u.id == user.id), false);
    });
  });

  group('UserViewModel', () {
    final vm = UserViewModel();

    test('add & fetch', () async {
      await vm.addUser("VM User", "vm@example.com");
      await vm.fetchUsers();
      expect(vm.users.any((u) => u.name == "VM User"), true);
    });
  });
}
