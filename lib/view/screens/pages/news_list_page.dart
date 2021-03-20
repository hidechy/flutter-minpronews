import 'package:flutter/material.dart';
import '../../components/search_bar.dart';
import '../../../view/components/category_chips.dart';
import '../../../data/category_info.dart';

import 'package:provider/provider.dart';
import '../../../viewmodels/news_list_viewmodel.dart';
import '../../../data/search_type.dart';

import '../../../models/model/news_model.dart';
import '../../../view/components/article_tile.dart';

import 'news_web_page_screen.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);

    if (!viewModel.isLoading && viewModel.articles.isEmpty) {
      Future(() => viewModel.getNews(
          searchType: SearchType.CATEGORY, category: categories[0]));
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "更新",
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword),
              ),
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
              ),
              Expanded(
                child: Consumer<NewsListViewModel>(
                  builder: (context, model, child) {
                    return model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: model.articles.length,
                            itemBuilder: (context, int position) => ArticleTile(
                              article: model.articles[position],
                              onArticleClicked: (article) =>
                                  _openArticleWebPage(article, context),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openArticleWebPage(Article article, BuildContext context) {
    print("_openArticleWebPage: ${article.url}");

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewsWebPageScreen(
        article: article,
      ),
    ));
  }

  Future<void> onRefresh(BuildContext context) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
        searchType: viewModel.searchType,
        keyword: viewModel.keyword,
        category: viewModel.category);
    print("NewsListPage.onRefresh");
  }

  Future<void> getKeywordNews(BuildContext context, keyword) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
        searchType: SearchType.KEYWORD,
        keyword: keyword,
        category: categories[0]);
    print("NewsListPage.getKeywordNews");
  }

  Future<void> getCategoryNews(BuildContext context, Category category) async {
    final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
    await viewModel.getNews(
        searchType: SearchType.CATEGORY, category: category);
    print("NewsListPage.getCategoryNews / category: ${category.nameJp}");
  }
}
