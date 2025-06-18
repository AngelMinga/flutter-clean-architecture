import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipesByAuthorId {
  final RecipeRepository repository;

  GetRecipesByAuthorId(this.repository);

  Future<List<Recipe>> call(String authorId) async {
    return await repository.getRecipesByAuthorId(authorId);
  }
}