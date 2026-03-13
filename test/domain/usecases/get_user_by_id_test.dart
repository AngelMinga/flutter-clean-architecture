import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/domain/usecases/get_user_by_id.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:clean_architecture/domain/entities/user.dart';

class MockUserRepository implements UserRepository {
  final List<User> _users = [
    const User(
      id: '1',
      name: 'Test User 1',
      email: 'test1@example.com',
      avatarUrl: 'https://example.com/avatar1.jpg',
    ),
    const User(
      id: '2',
      name: 'Test User 2',
      email: 'test2@example.com',
      avatarUrl: 'https://example.com/avatar2.jpg',
    ),
  ];

  bool throwError = false;

  @override
  Future<List<User>> getAllUsers() async {
    if (throwError) {
      throw Exception('Failed to get users');
    }
    return _users;
  }

  @override
  Future<User?> getUserById(String id) async {
    if (throwError) {
      throw Exception('Failed to get user');
    }
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }
}

void main() {
  late GetUserById useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserById(mockRepository);
  });

  test('should get user by id from the repository', () async {
    // Act
    final result = await useCase('1');

    // Assert
    expect(result, isA<User>());
    expect(result?.id, '1');
    expect(result?.name, 'Test User 1');
  });

  test('should return null when user is not found', () async {
    // Act
    final result = await useCase('999');

    // Assert
    expect(result, isNull);
  });

  test('should propagate exception when repository call fails', () async {
    // Arrange
    mockRepository.throwError = true;

    // Act & Assert
    expect(() => useCase('1'), throwsException);
  });
}