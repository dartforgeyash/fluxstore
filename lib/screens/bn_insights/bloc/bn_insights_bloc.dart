import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluxstore/constant/images.dart';
import 'package:fluxstore/screens/bn_insights/model/insights_models.dart';

part 'bn_insights_event.dart';
part 'bn_insights_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  InsightsBloc() : super(InsightsInitial()) {
    on<InsightsStarted>(_onInsightsStarted);
    on<InsightsCategoryChanged>(_onCategoryChanged);
    on<InsightsSearchChanged>(_onSearchChanged);
    on<InsightsHotTopicTapped>(_onHotTopicTapped);
    on<InsightsTipActionTapped>(_onTipActionTapped);
    on<InsightsSeeAllTapped>(_onSeeAllTapped);
    on<InsightsBottomNavTapped>(_onBottomNavTapped);
  }

  // ── Static seed data ────────────────────────────────────────────────────────

  static const List<CategoryTab> _categories = [
    CategoryTab(type: InsightsCategory.discover, label: 'Insights'),
    CategoryTab(type: InsightsCategory.news, label: 'News'),
    CategoryTab(type: InsightsCategory.mostViewed, label: 'Most Viewed'),
    CategoryTab(type: InsightsCategory.saved, label: 'Saved'),
  ];

  static const List<HotTopicModel> _hotTopics = [
    HotTopicModel(
      id: 'ht_1',
      imageUrl:
          'https://images.unsplash.com/photo-1584820927498-cfe5211fd8bf?w=400',
      title: 'Menstrual Cycle Basics',
    ),
    HotTopicModel(
      id: 'ht_2',
      imageUrl:
          'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=400',
      title: 'Hormonal Balance',
    ),
    HotTopicModel(
      id: 'ht_3',
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      title: 'Nutrition & Wellness',
    ),
  ];

  static final List<TipCardModel> _tips = [
    TipCardModel(
      id: 'tip_1',
      title: 'Connect with doctors & get suggestions',
      description: 'Connect now and get expert insights',
      actionLabel: 'View detail',
      imageUrl: AppImages.doctorImage // 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=200',
    ),
  ];

  static const List<CyclePhaseModel> _cyclePhases = [
    CyclePhaseModel(
      id: 'cp_1',
      title: 'Menstrual Phase',
      description: 'Days 1–5: Shedding of the uterine lining.',
      iconUrl: '',
    ),
    CyclePhaseModel(
      id: 'cp_2',
      title: 'Follicular Phase',
      description: 'Days 1–13: Follicles mature in the ovary.',
      iconUrl: '',
    ),
    CyclePhaseModel(
      id: 'cp_3',
      title: 'Ovulation',
      description: 'Day 14: Egg is released from the ovary.',
      iconUrl: '',
    ),
    CyclePhaseModel(
      id: 'cp_4',
      title: 'Luteal Phase',
      description: 'Days 15–28: Body prepares for possible pregnancy.',
      iconUrl: '',
    ),
  ];

  // ── Handlers ─────────────────────────────────────────────────────────────────

  Future<void> _onInsightsStarted(
    InsightsStarted event,
    Emitter<InsightsState> emit,
  ) async {
    emit(InsightsLoading());
    try {
      emit(
        InsightsLoaded(
          categories: _categories,
          selectedCategory: _categories.first,
          hotTopics: _hotTopics,
          tips: _tips,
          cyclePhases: _cyclePhases,
          searchQuery: '',
          currentNavIndex: 1,
        ),
      );
    } catch (e) {
      emit(InsightsError(e.toString()));
    }
  }

  void _onCategoryChanged(
    InsightsCategoryChanged event,
    Emitter<InsightsState> emit,
  ) {
    final current = state;
    if (current is! InsightsLoaded) return;
    if (current.selectedCategory == event.category) return;
    emit(current.copyWith(selectedCategory: event.category));
  }

  void _onSearchChanged(
    InsightsSearchChanged event,
    Emitter<InsightsState> emit,
  ) {
    final current = state;
    if (current is! InsightsLoaded) return;
    emit(current.copyWith(searchQuery: event.query));
  }

  void _onHotTopicTapped(
    InsightsHotTopicTapped event,
    Emitter<InsightsState> emit,
  ) {
    // emit(InsightsNavigateTo(
    //   route: AppRoutes.articleDetailScreen,
    //   arguments: event.topic,
    // ));
    final current = state;
    if (current is InsightsLoaded) emit(current);
  }

  void _onTipActionTapped(
    InsightsTipActionTapped event,
    Emitter<InsightsState> emit,
  ) {
    // emit(InsightsNavigateTo(
    //   route: AppRoutes.doctorConnectScreen,
    //   arguments: event.tip,
    // ));
    final current = state;
    if (current is InsightsLoaded) emit(current);
  }

  void _onSeeAllTapped(
    InsightsSeeAllTapped event,
    Emitter<InsightsState> emit,
  ) {
    emit(InsightsNavigateTo(route: event.route));
    final current = state;
    if (current is InsightsLoaded) emit(current);
  }

  void _onBottomNavTapped(
    InsightsBottomNavTapped event,
    Emitter<InsightsState> emit,
  ) {
    final current = state;
    if (current is! InsightsLoaded) return;
    if (current.currentNavIndex == event.index) return;
    emit(current.copyWith(currentNavIndex: event.index));
  }
}
