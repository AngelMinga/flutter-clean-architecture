import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final String imageUrl;
  final int preparationTimeMinutes;
  final String difficulty;
  final String authorId;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
    required this.preparationTimeMinutes,
    required this.difficulty,
    required this.authorId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        ingredients,
        steps,
        imageUrl,
        preparationTimeMinutes,
        difficulty,
        authorId,
      ];
}