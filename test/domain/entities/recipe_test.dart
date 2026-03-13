import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/domain/entities/recipe.dart';

void main() {
  group('Recipe Entity', () {
    test('should create a Recipe instance with all required properties', () {
      // Arrange
      const id = '1';
      const title = 'Spaghetti Carbonara';
      const description = 'A classic Italian pasta dish';
      final ingredients = ['Pasta', 'Eggs', 'Cheese', 'Pancetta'];
      final steps = ['Cook pasta', 'Mix eggs and cheese', 'Combine all ingredients'];
      const imageUrl = 'https://example.com/carbonara.jpg';
      const preparationTimeMinutes = 30;
      const difficulty = 'Medium';
      const authorId = '1';

      // Act
      final recipe = Recipe(
        id: id,
        title: title,
        description: description,
        ingredients: ingredients,
        steps: steps,
        imageUrl: imageUrl,
        preparationTimeMinutes: preparationTimeMinutes,
        difficulty: difficulty,
        authorId: authorId,
      );

      // Assert
      expect(recipe.id, id);
      expect(recipe.title, title);
      expect(recipe.description, description);
      expect(recipe.ingredients, ingredients);
      expect(recipe.steps, steps);
      expect(recipe.imageUrl, imageUrl);
      expect(recipe.preparationTimeMinutes, preparationTimeMinutes);
      expect(recipe.difficulty, difficulty);
      expect(recipe.authorId, authorId);
    });

    test('should consider two Recipes with the same properties as equal', () {
      // Arrange
      final recipe1 = Recipe(
        id: '1',
        title: 'Spaghetti Carbonara',
        description: 'A classic Italian pasta dish',
        ingredients: ['Pasta', 'Eggs', 'Cheese', 'Pancetta'],
        steps: ['Cook pasta', 'Mix eggs and cheese', 'Combine all ingredients'],
        imageUrl: 'https://example.com/carbonara.jpg',
        preparationTimeMinutes: 30,
        difficulty: 'Medium',
        authorId: '1',
      );

      final recipe2 = Recipe(
        id: '1',
        title: 'Spaghetti Carbonara',
        description: 'A classic Italian pasta dish',
        ingredients: ['Pasta', 'Eggs', 'Cheese', 'Pancetta'],
        steps: ['Cook pasta', 'Mix eggs and cheese', 'Combine all ingredients'],
        imageUrl: 'https://example.com/carbonara.jpg',
        preparationTimeMinutes: 30,
        difficulty: 'Medium',
        authorId: '1',
      );

      // Assert
      expect(recipe1, recipe2);
      expect(recipe1.hashCode, recipe2.hashCode);
    });

    test('should consider two Recipes with different properties as not equal', () {
      // Arrange
      final recipe1 = Recipe(
        id: '1',
        title: 'Spaghetti Carbonara',
        description: 'A classic Italian pasta dish',
        ingredients: ['Pasta', 'Eggs', 'Cheese', 'Pancetta'],
        steps: ['Cook pasta', 'Mix eggs and cheese', 'Combine all ingredients'],
        imageUrl: 'https://example.com/carbonara.jpg',
        preparationTimeMinutes: 30,
        difficulty: 'Medium',
        authorId: '1',
      );

      final recipe2 = Recipe(
        id: '2',
        title: 'Chicken Curry',
        description: 'A spicy Indian dish',
        ingredients: ['Chicken', 'Curry Powder', 'Coconut Milk'],
        steps: ['Cook chicken', 'Add curry powder', 'Add coconut milk'],
        imageUrl: 'https://example.com/curry.jpg',
        preparationTimeMinutes: 45,
        difficulty: 'Hard',
        authorId: '2',
      );

      // Assert
      expect(recipe1, isNot(recipe2));
      expect(recipe1.hashCode, isNot(recipe2.hashCode));
    });

    test('should have correct props for equality comparison', () {
      // Arrange
      final recipe = Recipe(
        id: '1',
        title: 'Spaghetti Carbonara',
        description: 'A classic Italian pasta dish',
        ingredients: ['Pasta', 'Eggs', 'Cheese', 'Pancetta'],
        steps: ['Cook pasta', 'Mix eggs and cheese', 'Combine all ingredients'],
        imageUrl: 'https://example.com/carbonara.jpg',
        preparationTimeMinutes: 30,
        difficulty: 'Medium',
        authorId: '1',
      );

      // Assert
      expect(recipe.props, [
        recipe.id,
        recipe.title,
        recipe.description,
        recipe.ingredients,
        recipe.steps,
        recipe.imageUrl,
        recipe.preparationTimeMinutes,
        recipe.difficulty,
        recipe.authorId,
      ]);
    });
  });
}