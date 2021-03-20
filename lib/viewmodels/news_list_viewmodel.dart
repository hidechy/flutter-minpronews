import 'package:flutter/material.dart';
import '../data/search_type.dart';
import '../data/category_info.dart';

import '../models/repository/news_repository.dart';

import '../models/model/news_model.dart';

class NewsListViewModel extends ChangeNotifier {
//  final NewsRepository _repository = NewsRepository();
  final NewsRepository _repository;

  NewsListViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article> _article = List();
  List<Article> get articles => _article;

  Future<void> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    _searchType = searchType;
    _keyword = keyword;
    _category = category;

    _isLoading = true;
    notifyListeners();

    print(
        "[ViewModel] searchType: $searchType / keyword: $keyword / category: ${category.nameJp}");

    _article = await _repository.getNews(
        searchType: _searchType, keyword: _keyword, category: _category);

    print(
        "searchType: $_searchType / keyword: $_keyword / category: $_category / articles: ${_article[0].title}");

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
