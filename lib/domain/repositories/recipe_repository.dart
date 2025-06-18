import '../entities/recipe.dart';

abstract class RecipeRepository {
  /// Get a list of all recipes
  Future<List<Recipe>> getAllRecipes();
  
  /// Get a recipe by ID
  Future<Recipe?> getRecipeById(String id);
  
  /// Get recipes by author ID
  Future<List<Recipe>> getRecipesByAuthorId(String authorId);
}