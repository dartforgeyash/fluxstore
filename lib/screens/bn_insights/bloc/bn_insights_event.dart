part of 'bn_insights_bloc.dart';

abstract class InsightsEvent extends Equatable {
  const InsightsEvent();

  @override
  List<Object?> get props => [];
}

class InsightsStarted extends InsightsEvent {}

class InsightsCategoryChanged extends InsightsEvent {
  final CategoryTab category;
  const InsightsCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class InsightsSearchChanged extends InsightsEvent {
  final String query;
  const InsightsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class InsightsHotTopicTapped extends InsightsEvent {
  final HotTopicModel topic;
  const InsightsHotTopicTapped(this.topic);

  @override
  List<Object?> get props => [topic];
}

class InsightsTipActionTapped extends InsightsEvent {
  final TipCardModel tip;
  const InsightsTipActionTapped(this.tip);

  @override
  List<Object?> get props => [tip];
}

class InsightsSeeAllTapped extends InsightsEvent {
  final String route;
  const InsightsSeeAllTapped(this.route);

  @override
  List<Object?> get props => [route];
}

class InsightsBottomNavTapped extends InsightsEvent {
  final int index;
  const InsightsBottomNavTapped(this.index);

  @override
  List<Object?> get props => [index];
}