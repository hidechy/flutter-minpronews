import 'package:flutter/material.dart';

import '../../models/model/news_model.dart';
import '../../view/style/styles.dart';

class ArticleTileDesc extends StatelessWidget {
  final Article article;

  ArticleTileDesc({this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${article.title}",
          style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          "${article.publishDate}",
          style: textTheme.overline.copyWith(fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          "${article.description}",
          style: textTheme.bodyText1.copyWith(fontFamily: ReqularFont),
        ),
      ],
    );
  }
}
