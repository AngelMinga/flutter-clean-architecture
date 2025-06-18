import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/recipe.dart';
import '../providers/providers.dart';
import 'recipe_detail_screen.dart';

class RecipeListScreen extends ConsumerWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllRecipes = ref.watch(getAllRecipesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: getAllRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          recipe.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.timer, size: 16),
                            const SizedBox(width: 4),
                            Text('${recipe.preparationTimeMinutes} min'),
                            const SizedBox(width: 16),
                            const Icon(Icons.bar_chart, size: 16),
                            const SizedBox(width: 4),
                            Text(recipe.difficulty),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailScreen(recipeId: recipe.id),
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
    );
  }
}