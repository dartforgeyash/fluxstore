part of 'bn_insights_bloc.dart';

abstract class InsightsState extends Equatable {
  const InsightsState();

  @override
  List<Object?> get props => [];
}

class InsightsInitial extends InsightsState {}

class InsightsLoading extends InsightsState {}

class InsightsLoaded extends InsightsState {
  final List<CategoryTab> categories;
  final CategoryTab selectedCategory;
  final List<HotTopicModel> hotTopics;
  final List<TipCardModel> tips;
  final List<CyclePhaseModel> cyclePhases;
  final String searchQuery;
  final int currentNavIndex;

  const InsightsLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.hotTopics,
    required this.tips,
    required this.cyclePhases,
    required this.searchQuery,
    required this.currentNavIndex,
  });

  InsightsLoaded copyWith({
    List<CategoryTab>? categories,
    CategoryTab? selectedCategory,
    List<HotTopicModel>? hotTopics,
    List<TipCardModel>? tips,
    List<CyclePhaseModel>? cyclePhases,
    String? searchQuery,
    int? currentNavIndex,
  }) {
    return InsightsLoaded(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      hotTopics: hotTopics ?? this.hotTopics,
      tips: tips ?? this.tips,
      cyclePhases: cyclePhases ?? this.cyclePhases,
      searchQuery: searchQuery ?? this.searchQuery,
      currentNavIndex: currentNavIndex ?? this.currentNavIndex,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    selectedCategory,
    hotTopics,
    tips,
    cyclePhases,
    searchQuery,
    currentNavIndex,
  ];
}

/// One-shot navigation state. BLoC immediately re-emits InsightsLoaded after.
class InsightsNavigateTo extends InsightsState {
  final String route;
  final Object? arguments;

  const InsightsNavigateTo({required this.route, this.arguments});

  @override
  List<Object?> get props => [route, arguments];
}

class InsightsError extends InsightsState {
  final String message;
  const InsightsError(this.message);

  @override
  List<Object?> get props => [message];
}