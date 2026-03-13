import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/domain/entities/user.dart';

void main() {
  group('User Entity', () {
    test('should create a User instance with all required properties', () {
      // Arrange
      const id = '1';
      const name = 'John Doe';
      const email = 'john.doe@example.com';
      const avatarUrl = 'https://example.com/avatar.jpg';

      // Act
      const user = User(
        id: id,
        name: name,
        email: email,
        avatarUrl: avatarUrl,
      );

      // Assert
      expect(user.id, id);
      expect(user.name, name);
      expect(user.email, email);
      expect(user.avatarUrl, avatarUrl);
    });

    test('should consider two Users with the same properties as equal', () {
      // Arrange
      const user1 = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      const user2 = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      // Assert
      expect(user1, user2);
      expect(user1.hashCode, user2.hashCode);
    });

    test('should consider two Users with different properties as not equal', () {
      // Arrange
      const user1 = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      const user2 = User(
        id: '2',
        name: 'Jane Smith',
        email: 'jane.smith@example.com',
        avatarUrl: 'https://example.com/avatar2.jpg',
      );

      // Assert
      expect(user1, isNot(user2));
      expect(user1.hashCode, isNot(user2.hashCode));
    });

    test('should have correct props for equality comparison', () {
      // Arrange
      const user = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
      );

      // Assert
      expect(user.props, [user.id, user.name, user.email, user.avatarUrl]);
    });
  });
}