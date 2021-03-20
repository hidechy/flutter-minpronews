import 'package:flutter/material.dart';

import 'page_transformer.dart';

class LazyLoadText extends StatelessWidget {
  final String text;

  final PageVisibility pageVisibility;

  LazyLoadText({this.text, this.pageVisibility});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: Alignment.topLeft,
        transform: Matrix4.translationValues(
            pageVisibility.pagePosition * 200, 0.0, 0.0),
        child: Text(
          text,
          style: textTheme.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
