import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/home/home_provider.dart';
import 'package:flutter_news_app/feature/home/sub/home_news_card.dart';
import 'package:flutter_news_app/feature/home/sub/home_search_delegate.dart';
import 'package:flutter_news_app/product/constants/color_constants.dart';
import 'package:flutter_news_app/product/models/tag_model.dart';
import 'package:flutter_news_app/product/widgets/text/subtitle_text.dart';
import 'package:flutter_news_app/product/widgets/text/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(_homeProvider.notifier).fetchAndLoad());

    ref.read(_homeProvider.notifier).addListener((state) {
      if (state.selectedTag != null) {
        _controller.text = state.selectedTag?.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: context.padding.normal,
          child: Stack(
            children: [
              ListView(
                children: [
                  const _Header(),
                  _CustomField(_controller),
                  const _TagListView(),
                  const _BrowseHorizontalListView(),
                  const _RecommendedHeader(),
                  const _RecommendedListView(),
                ],
              ),
              if (ref.watch(_homeProvider).isLoading ?? false)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomField extends ConsumerWidget {
  const _CustomField(this.controller);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onTap: () async {
        final response = await showSearch<Tag?>(
          context: context,
          delegate: HomeSearchDelegate(
            ref.read(_homeProvider.notifier).fullTagList,
          ),
        );
        ref.read(_homeProvider.notifier).updateSelectedTag(response);
      },
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.mic_outlined),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.shade300,
      ),
    );
  }
}

class _TagListView extends ConsumerWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItem = ref.watch(_homeProvider).tags ?? [];
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItem.length,
        itemBuilder: (BuildContext context, int index) {
          final tagItem = newsItem[index];
          if (tagItem.active ?? false) {
            return _PassiveChip(tagItem);
          }
          return _ActiveChip(tagItem);
        },
      ),
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip(this.tag);
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyRightLow,
      child: Chip(
        label: Text(tag.name ?? ''),
        padding: context.padding.low,
        backgroundColor: ColorConstants.purplePrimary,
      ),
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip(this.tag);
  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyRightLow,
      child: Chip(
        label: Text(tag.name ?? ''),
        padding: context.padding.low,
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

class _BrowseHorizontalListView extends ConsumerWidget {
  const _BrowseHorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItem = ref.watch(_homeProvider).news;
    return SizedBox(
      height: context.sized.dynamicHeight(.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItem?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return HomeNewsCard(
            newsItem: newsItem![index],
          );
        },
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TitleText(value: 'Recommended For You'),
          TextButton(
            onPressed: () {},
            child: const SubtitleText(
              value: 'See all',
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedListView extends ConsumerWidget {
  const _RecommendedListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(_homeProvider).recommended ?? [];
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Padding(
          padding: context.padding.onlyTopLow,
          child: ListTile(
            contentPadding: context.padding.low,
            leading: Image.network(
              item.image ?? '',
              fit: BoxFit.contain,
            ),
            title: Text(item.title ?? ''),
            subtitle: Text(item.description ?? ''),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(value: 'Browse'),
        SubtitleText(value: 'Discover Things'),
      ],
    );
  }
}
