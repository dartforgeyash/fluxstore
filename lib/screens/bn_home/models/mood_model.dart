enum MoodType { love, cool, happy, sad }

class MoodModel {
  final MoodType type;
  final String label;
  final String imagePath;

  const MoodModel({
    required this.type,
    required this.label,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MoodModel && type == other.type;

  @override
  int get hashCode => type.hashCode;
}