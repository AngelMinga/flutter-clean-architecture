import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/data/datasources/user_data_source.dart';
import 'package:clean_architecture/domain/entities/user.dart';

void main() {
  late MockUserDataSource dataSource;

  setUp(() {
    dataSource = MockUserDataSource();
  });

  group('getAllUsers', () {
    test('should return a list of users', () async {
      // Act
      final result = await dataSource.getAllUsers();

      // Assert
      expect(result, isA<List<User>>());
      expect(result.length, 4); // Based on the implementation in MockUserDataSource
      expect(result[0].id, '1');
      expect(result[0].name, 'John Doe');
      expect(result[1].id, '2');
      expect(result[1].name, 'Jane Smith');
    });
  });

  group('getUserById', () {
    test('should return a user when the id exists', () async {
      // Act
      final result = await dataSource.getUserById('1');

      // Assert
      expect(result, isA<User>());
      expect(result?.id, '1');
      expect(result?.name, 'John Doe');
      expect(result?.email, 'john.doe@example.com');
    });

    test('should throw an exception when the id does not exist', () async {
      // Act & Assert
      expect(() => dataSource.getUserById('999'), throwsException);
    });
  });
}