import '../../domain/entities/recipe.dart';

abstract class RecipeDataSource {
  Future<List<Recipe>> getAllRecipes();
  Future<Recipe?> getRecipeById(String id);
  Future<List<Recipe>> getRecipesByAuthorId(String authorId);
}

class MockRecipeDataSource implements RecipeDataSource {
  final List<Recipe> _recipes = [
    const Recipe(
      id: '1',
      title: 'Spaghetti Carbonara',
      description: 'A classic Italian pasta dish with eggs, cheese, and pancetta.',
      ingredients: [
        '200g spaghetti',
        '100g pancetta or bacon, diced',
        '2 large eggs',
        '50g Pecorino Romano cheese, grated',
        '50g Parmesan cheese, grated',
        'Freshly ground black pepper',
        'Salt to taste'
      ],
      steps: [
        'Cook the spaghetti in salted water according to package instructions.',
        'While the pasta is cooking, fry the pancetta in a large pan until crispy.',
        'In a bowl, whisk together the eggs, grated cheeses, and black pepper.',
        'Drain the pasta, reserving some cooking water.',
        'Add the hot pasta to the pan with the pancetta, remove from heat.',
        'Quickly stir in the egg and cheese mixture, adding a splash of cooking water if needed.',
        'Serve immediately with extra grated cheese and black pepper.'
      ],
      imageUrl: 'https://example.com/images/carbonara.jpg',
      preparationTimeMinutes: 25,
      difficulty: 'Medium',
      authorId: '1',
    ),
    const Recipe(
      id: '2',
      title: 'Chicken Curry',
      description: 'A flavorful Indian-inspired curry with tender chicken pieces.',
      ingredients: [
        '500g chicken breast, diced',
        '1 onion, finely chopped',
        '3 garlic cloves, minced',
        '1 tbsp ginger, grated',
        '2 tbsp curry powder',
        '1 can (400ml) coconut milk',
        '1 tbsp vegetable oil',
        'Salt and pepper to taste',
        'Fresh cilantro for garnish'
      ],
      steps: [
        'Heat oil in a large pan over medium heat.',
        'Add onion and cook until softened.',
        'Add garlic and ginger, cook for another minute.',
        'Add curry powder and stir for 30 seconds.',
        'Add chicken pieces and cook until browned.',
        'Pour in coconut milk, bring to a simmer.',
        'Cook for 15-20 minutes until chicken is cooked through.',
        'Season with salt and pepper.',
        'Garnish with fresh cilantro and serve with rice.'
      ],
      imageUrl: 'https://example.com/images/curry.jpg',
      preparationTimeMinutes: 40,
      difficulty: 'Easy',
      authorId: '2',
    ),
    const Recipe(
      id: '3',
      title: 'Chocolate Cake',
      description: 'A rich and moist chocolate cake that\'s perfect for any occasion.',
      ingredients: [
        '200g all-purpose flour',
        '250g granulated sugar',
        '75g cocoa powder',
        '1 tsp baking powder',
        '1 tsp baking soda',
        '2 eggs',
        '250ml milk',
        '125ml vegetable oil',
        '2 tsp vanilla extract',
        '250ml boiling water'
      ],
      steps: [
        'Preheat oven to 180°C (350°F) and grease two 9-inch cake pans.',
        'In a large bowl, mix flour, sugar, cocoa powder, baking powder, and baking soda.',
        'Add eggs, milk, oil, and vanilla extract; beat for 2 minutes.',
        'Stir in boiling water (batter will be thin).',
        'Pour into prepared pans and bake for 30-35 minutes.',
        'Let cool in pans for 10 minutes, then remove to wire racks.',
        'Once completely cool, frost with your favorite chocolate frosting.'
      ],
      imageUrl: 'https://example.com/images/chocolate_cake.jpg',
      preparationTimeMinutes: 60,
      difficulty: 'Medium',
      authorId: '3',
    ),
    const Recipe(
      id: '4',
      title: 'Greek Salad',
      description: 'A fresh and healthy Mediterranean salad with feta cheese and olives.',
      ingredients: [
        '1 cucumber, diced',
        '4 tomatoes, diced',
        '1 red onion, thinly sliced',
        '1 green bell pepper, diced',
        '200g feta cheese, cubed',
        '100g Kalamata olives',
        '2 tbsp extra virgin olive oil',
        '1 tbsp red wine vinegar',
        '1 tsp dried oregano',
        'Salt and pepper to taste'
      ],
      steps: [
        'Combine cucumber, tomatoes, onion, and bell pepper in a large bowl.',
        'Add olives and feta cheese.',
        'In a small bowl, whisk together olive oil, vinegar, oregano, salt, and pepper.',
        'Pour dressing over the salad and toss gently.',
        'Refrigerate for 30 minutes before serving for best flavor.'
      ],
      imageUrl: 'https://example.com/images/greek_salad.jpg',
      preparationTimeMinutes: 15,
      difficulty: 'Easy',
      authorId: '4',
    ),
  ];

  @override
  Future<List<Recipe>> getAllRecipes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _recipes;
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Recipe>> getRecipesByAuthorId(String authorId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _recipes.where((recipe) => recipe.authorId == authorId).toList();
  }
}