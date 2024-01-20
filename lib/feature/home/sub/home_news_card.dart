import 'package:flutter/material.dart';
import 'package:flutter_news_app/product/models/news_model.dart';
import 'package:flutter_news_app/product/widgets/text/white_title.dart';
import 'package:kartal/kartal.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({super.key, this.newsItem});
  final News? newsItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyRightNormal,
      child: Stack(
        children: [
          Image.network(
            newsItem!.backgroundImage ?? '',
            color: Colors.black.withOpacity(0.3),
            colorBlendMode: BlendMode.darken,
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
          Padding(
            padding: context.padding.low + context.padding.onlyLeftLow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: WhiteTitleText(value: newsItem!.category ?? ''),
                ),
                SizedBox(
                  width: 200,
                  child: WhiteSubtitleText(
                    value: newsItem!.title ?? '',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
