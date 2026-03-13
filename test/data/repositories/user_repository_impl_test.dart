import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture/data/datasources/user_data_source.dart';
import 'package:clean_architecture/domain/entities/user.dart';

class MockUserDataSource implements UserDataSource {
  final List<User> _users = [
    const User(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      avatarUrl: 'https://example.com/avatar.jpg',
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
  late UserRepositoryImpl repository;
  late MockUserDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockUserDataSource();
    repository = UserRepositoryImpl(mockDataSource);
  });

  group('getAllUsers', () {
    test('should return list of users when data source call is successful', () async {
      // Act
      final result = await repository.getAllUsers();

      // Assert
      expect(result, isA<List<User>>());
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].name, 'Test User');
    });

    test('should propagate exception when data source call fails', () async {
      // Arrange
      mockDataSource.throwError = true;

      // Act & Assert
      expect(() => repository.getAllUsers(), throwsException);
    });
  });

  group('getUserById', () {
    test('should return user when data source call is successful', () async {
      // Act
      final result = await repository.getUserById('1');

      // Assert
      expect(result, isA<User>());
      expect(result?.id, '1');
      expect(result?.name, 'Test User');
    });

    test('should return null when user is not found', () async {
      // Act
      final result = await repository.getUserById('999');

      // Assert
      expect(result, isNull);
    });

    test('should return null when data source call fails', () async {
      // Arrange
      mockDataSource.throwError = true;

      // Act
      final result = await repository.getUserById('1');

      // Assert
      expect(result, isNull);
    });
  });
}