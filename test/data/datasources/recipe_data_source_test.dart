import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/data/datasources/recipe_data_source.dart';
import 'package:clean_architecture/domain/entities/recipe.dart';

void main() {
  late MockRecipeDataSource dataSource;

  setUp(() {
    dataSource = MockRecipeDataSource();
  });

  group('getAllRecipes', () {
    test('should return a list of recipes', () async {
      // Act
      final result = await dataSource.getAllRecipes();

      // Assert
      expect(result, isA<List<Recipe>>());
      expect(result.length, 4); // Based on the implementation in MockRecipeDataSource
      expect(result[0].id, '1');
      expect(result[0].title, 'Spaghetti Carbonara');
      expect(result[1].id, '2');
      expect(result[1].title, 'Chicken Curry');
    });
  });

  group('getRecipeById', () {
    test('should return a recipe when the id exists', () async {
      // Act
      final result = await dataSource.getRecipeById('1');

      // Assert
      expect(result, isA<Recipe>());
      expect(result?.id, '1');
      expect(result?.title, 'Spaghetti Carbonara');
      expect(result?.authorId, '1');
    });

    test('should return null when the id does not exist', () async {
      // Act
      final result = await dataSource.getRecipeById('999');

      // Assert
      expect(result, isNull);
    });
  });

  group('getRecipesByAuthorId', () {
    test('should return a list of recipes for a specific author', () async {
      // Act
      final result = await dataSource.getRecipesByAuthorId('1');

      // Assert
      expect(result, isA<List<Recipe>>());
      expect(result.length, 1); // Based on the implementation in MockRecipeDataSource
      expect(result[0].id, '1');
      expect(result[0].title, 'Spaghetti Carbonara');
      expect(result[0].authorId, '1');
    });

    test('should return an empty list when no recipes found for author', () async {
      // Act
      final result = await dataSource.getRecipesByAuthorId('999');

      // Assert
      expect(result, isA<List<Recipe>>());
      expect(result.isEmpty, true);
    });
  });
}