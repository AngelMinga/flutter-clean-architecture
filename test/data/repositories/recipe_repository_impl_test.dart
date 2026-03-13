import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/data/repositories/recipe_repository_impl.dart';
import 'package:clean_architecture/data/datasources/recipe_data_source.dart';
import 'package:clean_architecture/domain/entities/recipe.dart';

class MockRecipeDataSource implements RecipeDataSource {
  final List<Recipe> _recipes = [
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

  bool throwError = false;

  @override
  Future<List<Recipe>> getAllRecipes() async {
    if (throwError) {
      throw Exception('Failed to get recipes');
    }
    return _recipes;
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    if (throwError) {
      throw Exception('Failed to get recipe');
    }
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Recipe>> getRecipesByAuthorId(String authorId) async {
    if (throwError) {
      throw Exception('Failed to get recipes by author');
    }
    return _recipes.where((recipe) => recipe.authorId == authorId).toList();
  }
}

void main() {
  late RecipeRepositoryImpl repository;
  late MockRecipeDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockRecipeDataSource();
    repository = RecipeRepositoryImpl(mockDataSource);
  });

  group('getAllRecipes', () {
    test('should return list of recipes when data source call is successful', () async {
      // Act
      final result = await repository.getAllRecipes();

      // Assert
      expect(result, isA<List<Recipe>>());
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].title, 'Test Recipe');
    });

    test('should propagate exception when data source call fails', () async {
      // Arrange
      mockDataSource.throwError = true;

      // Act & Assert
      expect(() => repository.getAllRecipes(), throwsException);
    });
  });

  group('getRecipeById', () {
    test('should return recipe when data source call is successful', () async {
      // Act
      final result = await repository.getRecipeById('1');

      // Assert
      expect(result, isA<Recipe>());
      expect(result?.id, '1');
      expect(result?.title, 'Test Recipe');
    });

    test('should return null when recipe is not found', () async {
      // Act
      final result = await repository.getRecipeById('999');

      // Assert
      expect(result, isNull);
    });

    test('should propagate exception when data source call fails', () async {
      // Arrange
      mockDataSource.throwError = true;

      // Act & Assert
      expect(() => repository.getRecipeById('1'), throwsException);
    });
  });

  group('getRecipesByAuthorId', () {
    test('should return list of recipes when data source call is successful', () async {
      // Act
      final result = await repository.getRecipesByAuthorId('1');

      // Assert
      expect(result, isA<List<Recipe>>());
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].authorId, '1');
    });

    test('should return empty list when no recipes found for author', () async {
      // Act
      final result = await repository.getRecipesByAuthorId('999');

      // Assert
      expect(result, isA<List<Recipe>>());
      expect(result.isEmpty, true);
    });

    test('should propagate exception when data source call fails', () async {
      // Arrange
      mockDataSource.throwError = true;

      // Act & Assert
      expect(() => repository.getRecipesByAuthorId('1'), throwsException);
    });
  });
}