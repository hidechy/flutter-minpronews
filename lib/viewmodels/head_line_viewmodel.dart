import 'package:flutter/material.dart';

import '../data/search_type.dart';
import '../data/category_info.dart';
import '../models/repository/news_repository.dart';
import '../models/model/news_model.dart';

class HeadLineViewModel extends ChangeNotifier {
//  final NewsRepository _repository = NewsRepository();
  final NewsRepository _repository;

  HeadLineViewModel({repository}) : _repository = repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article> _article = List();
  List<Article> get articles => _article;

  Future<void> getHeadLines({@required SearchType head_line}) async {
    _searchType = searchType;
    _isLoading = true;
    notifyListeners();

    _article = await _repository.getNews(searchType: SearchType.HEAD_LINE);

    print("searchType: $_searchType / articles: ${_article[0].title}");

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
