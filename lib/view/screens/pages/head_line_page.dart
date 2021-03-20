import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../data/search_type.dart';
import '../../../viewmodels/head_line_viewmodel.dart';

import '../../../view/components/page_transformer.dart';

import '../../../view/components/head_line_item.dart';
import '../../../models/model/news_model.dart';

import 'news_web_page_screen.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getHeadLines(head_line: SearchType.HEAD_LINE));
    }
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<HeadLineViewModel>(
            builder: (context, model, child) {
              if (model.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageTransformer(
                  pageViewBuilder: (context, pageVisibilityResolver) {
                    return PageView.builder(
                        controller: PageController(viewportFraction: 0.8),
                        itemCount: model.articles.length,
                        itemBuilder: (context, index) {
                          final article = model.articles[index];

                          final pageVisibility = pageVisibilityResolver
                              .resolvePageVisibility(index);

                          final visibleFraction =
                              pageVisibility.visibleFraction;

                          return HeadLineItem(
                            article: model.articles[index],
                            pageVisibility: pageVisibility,
                            onArticleClicked: (article) =>
                                _openArticleWebPage(article, context),
                          );
                        });
                  },
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => onRefresh(context),
        ),
      ),
    );
  }

  _openArticleWebPage(Article article, BuildContext context) {
    print("HeadLinePage._openArticleWebPage: ${article.url}");

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewsWebPageScreen(
        article: article,
      ),
    ));
  }

  onRefresh(BuildContext context) async {
    print("HeadLinePage.onRefresh");

    final viewModel = Provider.of<HeadLineViewModel>(context, listen: false);
    await viewModel.getHeadLines(head_line: SearchType.HEAD_LINE);
  }
}
