// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_news_app/product/models/news_model.dart';
import 'package:flutter_news_app/product/utility/firebase/firebase_collections.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

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

    final values = response.docs.map((e) => e.data()).toList();
    state = state.copyWith(news: values);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    await fetchNews();
    state = state.copyWith(isLoading: false);
  }
}

class HomeState extends Equatable {
  const HomeState({this.isLoading, this.news});

  final List<News>? news;
  final bool? isLoading;

  @override
  List<Object?> get props => [news, isLoading];

  HomeState copyWith({
    List<News>? news,
    bool? isLoading,
  }) {
    return HomeState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
