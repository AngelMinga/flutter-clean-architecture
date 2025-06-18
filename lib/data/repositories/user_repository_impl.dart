import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<User>> getAllUsers() async {
    return await dataSource.getAllUsers();
  }

  @override
  Future<User?> getUserById(String id) async {
    try {
      return await dataSource.getUserById(id);
    } catch (e) {
      return null;
    }
  }
}