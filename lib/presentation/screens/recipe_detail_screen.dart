import 'package:flutter/material.dart';

// Import data sources
import '../../data/datasources/recipe_data_source.dart';
import '../../data/datasources/user_data_source.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user.dart';
import 'user_detail_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  Future<Recipe?> _getRecipeById(String id) async {
    final dataSource = MockRecipeDataSource();
    return dataSource.getRecipeById(id);
  }

  Future<User?> _getUserById(String id) async {
    final dataSource = MockUserDataSource();
    return dataSource.getUserById(id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Recipe?>(
        future: _getRecipeById(recipeId),
        builder: (context, recipeSnapshot) {
          if (recipeSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (recipeSnapshot.hasError) {
            return Center(child: Text('Error: ${recipeSnapshot.error}'));
          } else if (!recipeSnapshot.hasData) {
            return const Center(child: Text('Recipe not found'));
          } else {
            final recipe = recipeSnapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer),
                      const SizedBox(width: 4),
                      Text('${recipe.preparationTimeMinutes} minutes'),
                      const SizedBox(width: 16),
                      const Icon(Icons.bar_chart),
                      const SizedBox(width: 4),
                      Text(recipe.difficulty),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<User?>(
                    future: _getUserById(recipe.authorId),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (userSnapshot.hasError ||
                          !userSnapshot.hasData) {
                        return const Text('Author: Unknown');
                      } else {
                        final user = userSnapshot.data!;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailScreen(userId: user.id),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(user.avatarUrl),
                                radius: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'By ${user.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recipe.description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map((ingredient) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(child: Text(ingredient)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(
                    recipe.steps.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Text(recipe.steps[index])),
                        ],
                      ),
                    ),
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
