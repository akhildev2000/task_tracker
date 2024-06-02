import '../models/user.dart';

class AuthService {
  List<User> users = [
    User(
      id: '1',
      username: 'manager',
      password: 'password',
      role: 'Manager',
    ),
    User(
      id: '2',
      username: 'employee001',
      password: 'password',
      role: 'Employee',
    ),
    User(
      id: '2',
      username: 'employee002',
      password: 'password',
      role: 'Employee',
    ),
    User(
      id: '2',
      username: 'employee003',
      password: 'password',
      role: 'Employee',
    ),
  ];

  Future<User?> login(String username, String password) async {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  Future<void> logout() async {
    users.clear();
  }
}
