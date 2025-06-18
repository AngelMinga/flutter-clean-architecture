import '../entities/user.dart';

abstract class UserRepository {
  /// Get a list of all users
  Future<List<User>> getAllUsers();
  
  /// Get a user by ID
  Future<User?> getUserById(String id);
}