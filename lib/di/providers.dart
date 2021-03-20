import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/db/dao.dart';
import '../models/db/database.dart';

import '../models/networking/api_service.dart';
import '../models/repository/news_repository.dart';

import '../viewmodels/head_line_viewmodel.dart';
import '../viewmodels/news_list_viewmodel.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<ApiService>(
    create: (_) => ApiService.create(),
    dispose: (_, apiService) => apiService.dispose(),
  ),
  Provider<MyDatabase>(
    create: (_) => MyDatabase(),
    dispose: (_, db) => db.close(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<MyDatabase, NewsDao>(
    update: (_, db, dao) => NewsDao(db),
  ),
  ProxyProvider2<NewsDao, ApiService, NewsRepository>(
    update: (_, dao, apiService, repository) =>
        NewsRepository(dao: dao, apiService: apiService),
  )
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<HeadLineViewModel>(
    create: (context) => HeadLineViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<NewsListViewModel>(
    create: (context) => NewsListViewModel(
      repository: Provider.of<NewsRepository>(context, listen: false),
    ),
  ),
];
