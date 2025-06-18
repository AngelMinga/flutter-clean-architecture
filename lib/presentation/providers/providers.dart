import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/recipe_data_source.dart';
import '../../data/datasources/user_data_source.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_all_recipes.dart';
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_recipe_by_id.dart';
import '../../domain/usecases/get_recipes_by_author_id.dart';
import '../../domain/usecases/get_user_by_id.dart';

// Data Sources
final userDataSourceProvider = Provider<UserDataSource>((ref) {
  return MockUserDataSource();
});

final recipeDataSourceProvider = Provider<RecipeDataSource>((ref) {
  return MockRecipeDataSource();
});

// Repositories
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dataSource = ref.watch(userDataSourceProvider);
  return UserRepositoryImpl(dataSource);
});

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  final dataSource = ref.watch(recipeDataSourceProvider);
  return RecipeRepositoryImpl(dataSource);
});

// Use Cases
final getAllUsersProvider = Provider<GetAllUsers>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetAllUsers(repository);
});

final getUserByIdProvider = Provider<GetUserById>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserById(repository);
});

final getAllRecipesProvider = Provider<GetAllRecipes>((ref) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetAllRecipes(repository);
});

final getRecipeByIdProvider = Provider<GetRecipeById>((ref) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetRecipeById(repository);
});

final getRecipesByAuthorIdProvider = Provider<GetRecipesByAuthorId>((ref) {
  final repository = ref.watch(recipeRepositoryProvider);
  return GetRecipesByAuthorId(repository);
});