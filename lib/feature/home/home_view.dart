import 'package:flutter/material.dart';
import 'package:flutter_news_app/product/constants/color_constants.dart';
import 'package:flutter_news_app/product/widgets/text/subtitle_text.dart';
import 'package:flutter_news_app/product/widgets/text/title_text.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: context.padding.normal,
          child: ListView(
            children: const [
              _Header(),
              _CustomField(),
              _TagListView(),
              _BrowseHorizontalListView(),
              _RecommendedHeader(),
              _RecommendedListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  const _CustomField();

  @override
  Widget build(BuildContext context) {
    return TextField(
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

class _TagListView extends StatelessWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) {
            return const _PassiveChip();
          }
          return const _ActiveChip();
        },
      ),
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyRightLow,
      child: Chip(
        label: const Text('Label Active'),
        padding: context.padding.low,
        backgroundColor: ColorConstants.purplePrimary,
      ),
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyRightLow,
      child: Chip(
        label: const Text('Label Passive'),
        padding: context.padding.low,
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

class _BrowseHorizontalListView extends StatelessWidget {
  const _BrowseHorizontalListView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: context.padding.onlyRightNormal,
            child: const Placeholder(),
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

class _RecommendedListView extends StatelessWidget {
  const _RecommendedListView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: context.padding.onlyTopLow,
          child: const Placeholder(),
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
