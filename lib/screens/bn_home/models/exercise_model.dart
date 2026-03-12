enum ExerciseType { relaxation, meditation, breathing, yoga }

class ExerciseModel {
  final ExerciseType type;
  final String title;
  final String imagePath;
  final String routeName;

  const ExerciseModel({
    required this.type,
    required this.title,
    required this.imagePath,
    required this.routeName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ExerciseModel && type == other.type;

  @override
  int get hashCode => type.hashCode;
}