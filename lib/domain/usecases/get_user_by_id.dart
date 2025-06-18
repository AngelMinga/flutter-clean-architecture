import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserById {
  final UserRepository repository;

  GetUserById(this.repository);

  Future<User?> call(String id) async {
    return await repository.getUserById(id);
  }
}