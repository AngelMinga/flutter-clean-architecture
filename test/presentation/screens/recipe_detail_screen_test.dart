import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/presentation/screens/recipe_detail_screen.dart';
import 'package:clean_architecture/presentation/screens/user_detail_screen.dart';
import 'package:clean_architecture/domain/entities/user.dart';
import 'package:clean_architecture/domain/entities/recipe.dart';
import 'package:clean_architecture/data/datasources/user_data_source.dart';
import 'package:clean_architecture/data/datasources/recipe_data_source.dart';

// Mock implementations to avoid network calls during tests
class MockRecipeDataSourceForTest extends MockRecipeDataSource {
  @override
  Future<Recipe?> getRecipeById(String id) async {
    if (id == '1') {
      return Recipe(
        id: '1',
        title: 'Test Recipe',
        description: 'Test Description',
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        steps: ['Step 1', 'Step 2'],
        imageUrl: 'https://example.com/recipe.jpg',
        preparationTimeMinutes: 30,
        difficulty: 'Easy',
        authorId: '1',
      );
    }
    return null;
  }
}

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

void main() {
  testWidgets('RecipeDetailScreen should display recipe details and author', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: RecipeDetailScreen(recipeId: '1'),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));

    // Verify that the title is displayed
    expect(find.text('Recipe Details'), findsOneWidget);

    // Verify that recipe details are displayed
    // Note: This test might be flaky because it depends on the actual implementation
    // of MockRecipeDataSource which might change. In a real app, we would use dependency
    // injection to provide a mock data source for testing.
    expect(find.text('Spaghetti Carbonara'), findsOneWidget);
    expect(find.text('A classic Italian pasta dish with eggs, cheese, and pancetta.'), findsOneWidget);
    
    // Wait for the nested FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));
    
    // Verify that author information is displayed
    expect(find.text('By John Doe'), findsOneWidget);
    
    // Verify that ingredients and steps sections are displayed
    expect(find.text('Ingredients'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
  });

  testWidgets('RecipeDetailScreen should navigate to UserDetailScreen when author is tapped',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: RecipeDetailScreen(recipeId: '1'),
      ),
    );

    // Wait for the FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));
    
    // Wait for the nested FutureBuilder to complete
    await tester.pump(Duration(milliseconds: 500));

    // Tap on the author
    await tester.tap(find.text('By John Doe'));
    await tester.pumpAndSettle();

    // Verify that UserDetailScreen is displayed
    expect(find.byType(UserDetailScreen), findsOneWidget);
  });
}