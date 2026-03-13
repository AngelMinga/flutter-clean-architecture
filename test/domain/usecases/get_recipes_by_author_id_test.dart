import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/domain/usecases/get_recipes_by_author_id.dart';
import 'package:clean_architecture/domain/repositories/recipe_repository.dart';
import 'package:clean_architecture/domain/entities/recipe.dart';

class MockRecipeRepository implements RecipeRepository {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Test Recipe 1',
      description: 'Test Description 1',
      ingredients: ['Ingredient 1', 'Ingredient 2'],
      steps: ['Step 1', 'Step 2'],
      imageUrl: 'https://example.com/recipe1.jpg',
      preparationTimeMinutes: 30,
      difficulty: 'Easy',
      authorId: '1',
    ),
    Recipe(
      id: '2',
      title: 'Test Recipe 2',
      description: 'Test Description 2',
      ingredients: ['Ingredient 3', 'Ingredient 4'],
      steps: ['Step 3', 'Step 4'],
      imageUrl: 'https://example.com/recipe2.jpg',
      preparationTimeMinutes: 45,
      difficulty: 'Medium',
      authorId: '1',
    ),
    Recipe(
      id: '3',
      title: 'Test Recipe 3',
      description: 'Test Description 3',
      ingredients: ['Ingredient 5', 'Ingredient 6'],
      steps: ['Step 5', 'Step 6'],
      imageUrl: 'https://example.com/recipe3.jpg',
      preparationTimeMinutes: 60,
      difficulty: 'Hard',
      authorId: '2',
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
  late GetRecipesByAuthorId useCase;
  late MockRecipeRepository mockRepository;

  setUp(() {
    mockRepository = MockRecipeRepository();
    useCase = GetRecipesByAuthorId(mockRepository);
  });

  test('should get recipes by author id from the repository', () async {
    // Act
    final result = await useCase('1');

    // Assert
    expect(result, isA<List<Recipe>>());
    expect(result.length, 2);
    expect(result[0].id, '1');
    expect(result[0].authorId, '1');
    expect(result[1].id, '2');
    expect(result[1].authorId, '1');
  });

  test('should return empty list when no recipes found for author', () async {
    // Act
    final result = await useCase('999');

    // Assert
    expect(result, isA<List<Recipe>>());
    expect(result.isEmpty, true);
  });

  test('should propagate exception when repository call fails', () async {
    // Arrange
    mockRepository.throwError = true;

    // Act & Assert
    expect(() => useCase('1'), throwsException);
  });
}