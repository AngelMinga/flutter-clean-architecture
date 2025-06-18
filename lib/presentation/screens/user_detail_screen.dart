import 'package:flutter/material.dart';

import '../../data/datasources/recipe_data_source.dart';
import '../../data/datasources/user_data_source.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user.dart';
import 'recipe_detail_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  Future<User?> _getUserById(String id) async {
    final dataSource = MockUserDataSource();
    return dataSource.getUserById(id);
  }

  Future<List<Recipe>> _getRecipesByAuthorId(String authorId) async {
    final dataSource = MockRecipeDataSource();
    return dataSource.getRecipesByAuthorId(authorId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<User?>(
        future: _getUserById(userId),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          } else if (!userSnapshot.hasData) {
            return const Center(child: Text('User not found'));
          } else {
            final user = userSnapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Recipes by this user:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Recipe>>(
                    future: _getRecipesByAuthorId(userId),
                    builder: (context, recipesSnapshot) {
                      if (recipesSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (recipesSnapshot.hasError) {
                        return Center(
                            child: Text('Error: ${recipesSnapshot.error}'));
                      } else if (!recipesSnapshot.hasData ||
                          recipesSnapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No recipes found for this user'));
                      } else {
                        final recipes = recipesSnapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text(recipe.title),
                                subtitle: Text(
                                  recipe.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  '${recipe.preparationTimeMinutes} min',
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeDetailScreen(
                                          recipeId: recipe.id),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
