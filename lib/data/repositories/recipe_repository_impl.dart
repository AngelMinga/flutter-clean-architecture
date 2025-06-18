import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSource dataSource;

  RecipeRepositoryImpl(this.dataSource);

  @override
  Future<List<Recipe>> getAllRecipes() async {
    return await dataSource.getAllRecipes();
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    return await dataSource.getRecipeById(id);
  }

  @override
  Future<List<Recipe>> getRecipesByAuthorId(String authorId) async {
    return await dataSource.getRecipesByAuthorId(authorId);
  }
}