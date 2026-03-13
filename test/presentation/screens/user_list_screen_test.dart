import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/presentation/screens/user_list_screen.dart';
import 'package:clean_architecture/presentation/screens/user_detail_screen.dart';
import 'package:clean_architecture/domain/entities/user.dart';
import 'package:clean_architecture/data/datasources/user_data_source.dart';

// Mock implementation to avoid network calls during tests
class MockUserDataSourceForTest extends MockUserDataSource {
  @override
  Future<List<User>> getAllUsers() async {
    // Return a fixed list of users for testing
    return [
      const User(
        id: '1',
        name: 'Test User 1',
        email: 'test1@example.com',
        avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      ),
      const User(
        id: '2',
        name: 'Test User 2',
        email: 'test2@example.com',
        avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      ),
    ];
  }
}

void main() {
  testWidgets('UserListScreen should display a list of users', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));

    // Verify that the title is displayed
    expect(find.text('Users'), findsOneWidget);

    // Verify that user items are displayed
    // Note: This test might be flaky because it depends on the actual implementation
    // of MockUserDataSource which might change. In a real app, we would use dependency
    // injection to provide a mock data source for testing.
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('jane.smith@example.com'), findsOneWidget);
  });

  testWidgets('UserListScreen should navigate to UserDetailScreen when a user is tapped',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));

    // Tap on the first user
    await tester.tap(find.text('John Doe'));
    await tester.pumpAndSettle();

    // Verify that UserDetailScreen is displayed
    expect(find.byType(UserDetailScreen), findsOneWidget);
  });
}