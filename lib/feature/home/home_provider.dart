import 'package:equatable/equatable.dart';
import 'package:flutter_news_app/product/models/news_model.dart';
import 'package:flutter_news_app/product/models/recommended_model.dart';
import 'package:flutter_news_app/product/models/tag_model.dart';
import 'package:flutter_news_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_news_app/product/utility/firebase/firebase_utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  List<Tag> _fullTagList = [];
  List<Tag> get fullTagList => _fullTagList;

  Future<void> fetchNews() async {
    final newsCollection = FirebaseCollections.news.reference;

    final response = await newsCollection.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(news: values);
    }
  }

  Future<void> fetchTags() async {
    final items =
        await fetchList<Tag, Tag>(const Tag(), FirebaseCollections.tags);
    state = state.copyWith(tags: items);
    _fullTagList = items ?? [];
  }

  Future<void> fetchRecommended() async {
    final items = await fetchList<Recommended, Recommended>(
      const Recommended(),
      FirebaseCollections.recommended,
    );
    state = state.copyWith(recommended: items);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    await Future.wait([fetchNews(), fetchTags(), fetchRecommended()]);
    state = state.copyWith(isLoading: false);
  }

  void updateSelectedTag(Tag? tag) {
    if (tag == null) return;
    state = state.copyWith(selectedTag: tag);
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.selectedTag,
    this.recommended,
    this.isLoading,
    this.news,
    this.tags,
  });

  final List<News>? news;
  final List<Tag>? tags;
  final List<Recommended>? recommended;
  final bool? isLoading;
  final Tag? selectedTag;

  @override
  List<Object?> get props => [news, isLoading, tags, recommended, selectedTag];

  HomeState copyWith({
    List<News>? news,
    List<Tag>? tags,
    List<Recommended>? recommended,
    bool? isLoading,
    Tag? selectedTag,
  }) {
    return HomeState(
      selectedTag: selectedTag ?? this.selectedTag,
      recommended: recommended ?? this.recommended,
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
      tags: tags ?? this.tags,
    );
  }
}
