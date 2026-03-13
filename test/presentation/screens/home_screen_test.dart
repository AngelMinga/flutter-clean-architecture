import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/presentation/screens/home_screen.dart';
import 'package:clean_architecture/presentation/screens/user_list_screen.dart';
import 'package:clean_architecture/presentation/screens/recipe_list_screen.dart';

void main() {
  testWidgets('HomeScreen should display title and buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify that the title is displayed
    expect(find.text('Clean Architecture Demo'), findsOneWidget);
    expect(find.text('Clean Architecture + Riverpod Demo'), findsOneWidget);

    // Verify that the buttons are displayed
    expect(find.text('View Users'), findsOneWidget);
    expect(find.text('View Recipes'), findsOneWidget);
  });

  testWidgets('HomeScreen should navigate to UserListScreen when View Users button is tapped',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Tap the 'View Users' button
    await tester.tap(find.text('View Users'));
    await tester.pumpAndSettle();

    // Verify that UserListScreen is displayed
    expect(find.byType(UserListScreen), findsOneWidget);
  });

  testWidgets('HomeScreen should navigate to RecipeListScreen when View Recipes button is tapped',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Tap the 'View Recipes' button
    await tester.tap(find.text('View Recipes'));
    await tester.pumpAndSettle();

    // Verify that RecipeListScreen is displayed
    expect(find.byType(RecipeListScreen), findsOneWidget);
  });
}