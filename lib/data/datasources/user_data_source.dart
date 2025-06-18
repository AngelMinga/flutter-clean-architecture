import '../../domain/entities/user.dart';

abstract class UserDataSource {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
}

class MockUserDataSource implements UserDataSource {
  final List<User> _users = [
    const User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
    const User(
      id: '2',
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
    const User(
      id: '3',
      name: 'Michael Johnson',
      email: 'michael.johnson@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    ),
    const User(
      id: '4',
      name: 'Emily Davis',
      email: 'emily.davis@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
    ),
  ];

  @override
  Future<List<User>> getAllUsers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _users;
  }

  @override
  Future<User?> getUserById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _users.firstWhere(
      (user) => user.id == id,
      orElse: () => throw Exception('User not found'),
    );
  }
}