import 'package:flutter/material.dart';
import '../data/user_repository.dart';
import '../domain/user.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repo = UserRepository();
  List<User> users = [];

  Future<void> fetchUsers() async {
    users = await _repo.listUsers();
    notifyListeners();
  }

  Future<User> addUser(String name, String email) async {
    final user = await _repo.createUser(
      User(name: name, email: email),
    );
    await fetchUsers();
    return user;
  }

  Future<User> updateUser(int id, String name, String email) async {
    final user = await _repo.updateUser(
      User(id: id, name: name, email: email),
    );
    await fetchUsers();
    return user;
  }

  Future<void> deleteUser(int id) async {
    await _repo.deleteUser(id);
    await fetchUsers();
  }
}
