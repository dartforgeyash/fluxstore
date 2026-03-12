// ── Category Tab ─────────────────────────────────────────────────────────────

enum InsightsCategory { discover, news, mostViewed, saved }

class CategoryTab {
  final InsightsCategory type;
  final String label;

  const CategoryTab({required this.type, required this.label});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CategoryTab && type == other.type;

  @override
  int get hashCode => type.hashCode;
}

// ── Hot Topic ─────────────────────────────────────────────────────────────────

class HotTopicModel {
  final String id;
  final String imageUrl;
  final String title;

  const HotTopicModel({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is HotTopicModel && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ── Tip Card ──────────────────────────────────────────────────────────────────

class TipCardModel {
  final String id;
  final String title;
  final String description;
  final String actionLabel;
  final String imageUrl;

  const TipCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.imageUrl,
  });
}

// ── Cycle Phase ───────────────────────────────────────────────────────────────

class CyclePhaseModel {
  final String id;
  final String title;
  final String description;
  final String iconUrl;

  const CyclePhaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
  });
}