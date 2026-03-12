class SessionModel {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String illustrationPath;

  const SessionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.illustrationPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SessionModel && id == other.id;

  @override
  int get hashCode => id.hashCode;
}