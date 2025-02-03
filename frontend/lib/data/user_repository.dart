import '../domain/user.dart';

class UserRepository {
  final List<User> _users = [];
  int _nextId = 1;

  Future<User> createUser(User user) async {
    final newUser =
        User(id: _nextId++, name: user.name, email: user.email);
    _users.add(newUser);
    return newUser;
  }

  Future<User> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index == -1) throw Exception('User not found');
    _users[index] = user;
    return user;
  }

  Future<void> deleteUser(int id) async {
    _users.removeWhere((u) => u.id == id);
  }

  Future<List<User>> listUsers() async => _users;
}
