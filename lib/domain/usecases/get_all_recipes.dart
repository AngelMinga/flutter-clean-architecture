import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetAllRecipes {
  final RecipeRepository repository;

  GetAllRecipes(this.repository);

  Future<List<Recipe>> call() async {
    return await repository.getAllRecipes();
  }
}