import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/presentation/screens/user_detail_screen.dart';
import 'package:clean_architecture/presentation/screens/recipe_detail_screen.dart';
import 'package:clean_architecture/domain/entities/user.dart';
import 'package:clean_architecture/domain/entities/recipe.dart';
import 'package:clean_architecture/data/datasources/user_data_source.dart';
import 'package:clean_architecture/data/datasources/recipe_data_source.dart';

// Mock implementations to avoid network calls during tests
class MockUserDataSourceForTest extends MockUserDataSource {
  @override
  Future<User?> getUserById(String id) async {
    if (id == '1') {
      return const User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      );
    }
    return null;
  }
}

class MockRecipeDataSourceForTest extends MockRecipeDataSource {
  @override
  Future<List<Recipe>> getRecipesByAuthorId(String authorId) async {
    if (authorId == '1') {
      return [
        Recipe(
          id: '1',
          title: 'Test Recipe',
          description: 'Test Description',
          ingredients: ['Ingredient 1', 'Ingredient 2'],
          steps: ['Step 1', 'Step 2'],
          imageUrl: 'https://example.com/recipe.jpg',
          preparationTimeMinutes: 30,
          difficulty: 'Easy',
          authorId: '1',
        ),
      ];
    }
    return [];
  }
}

void main() {
  testWidgets('UserDetailScreen should display user details and recipes', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: UserDetailScreen(userId: '1'),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));

    // Verify that the title is displayed
    expect(find.text('User Details'), findsOneWidget);

    // Verify that user details are displayed
    // Note: This test might be flaky because it depends on the actual implementation
    // of MockUserDataSource which might change. In a real app, we would use dependency
    // injection to provide a mock data source for testing.
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);

    // Verify that recipes section is displayed
    expect(find.text('Recipes by this user:'), findsOneWidget);
    
    // Wait for the nested FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));
    
    // Verify that recipe items are displayed
    expect(find.text('Spaghetti Carbonara'), findsOneWidget);
  });

  testWidgets('UserDetailScreen should navigate to RecipeDetailScreen when a recipe is tapped',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: UserDetailScreen(userId: '1'),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));
    
    // Wait for the nested FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));

    // Tap on the recipe
    await tester.tap(find.text('Spaghetti Carbonara'));
    await tester.pumpAndSettle();

    // Verify that RecipeDetailScreen is displayed
    expect(find.byType(RecipeDetailScreen), findsOneWidget);
  });
}