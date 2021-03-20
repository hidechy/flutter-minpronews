import 'package:flutter/material.dart';

import '../../models/model/news_model.dart';
import '../../view/components/image_from_url.dart';
import '../../view/components/page_transformer.dart';

import 'lazy_load_text.dart';

class HeadLineItem extends StatelessWidget {
  final Article article;
  final PageVisibility pageVisibility;
  final ValueChanged onArticleClicked;

  HeadLineItem({this.article, this.pageVisibility, this.onArticleClicked});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () => onArticleClicked(article),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.blueAccent, Colors.black26]),
              ),
              child: ImageFromUrl(
                imageUrl: article.urlToImage,
              ),
            ),
            Positioned(
              bottom: 56.0,
              left: 32.0,
              right: 32.0,
              child: LazyLoadText(
                text: article.title,
                pageVisibility: pageVisibility,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
