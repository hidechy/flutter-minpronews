import 'package:flutter/material.dart';
import '../../data/category_info.dart';
import '../../data/search_type.dart';

import '../model/news_model.dart';
import '../networking/api_service.dart';

import 'package:chopper/chopper.dart';

import '../../util/extensions.dart';

import '../../models/db/dao.dart';

class NewsRepository {
  final ApiService _apiService;
  final NewsDao _dao;

  NewsRepository({dao, apiService})
      : _apiService = apiService,
        _dao = dao;

  Future<List<Article>> getNews(
      {@required SearchType searchType,
      String keyword,
      Category category}) async {
    List<Article> result = List<Article>();

    Response response;

    try {
      switch (searchType) {
        case SearchType.HEAD_LINE:
          response = await _apiService.getHeadLines();
          break;
        case SearchType.KEYWORD:
          response = await _apiService.getKeywordNews(keyword: keyword);
          break;
        case SearchType.CATEGORY:
          response =
              await _apiService.getCategoryNews(category: category.nameEn);
          break;
      }
      if (response.isSuccessful) {
        final responseBody = response.body;
        print("responseBody: $responseBody");
//        result = News.fromJson(responseBody).articles;

        result = await insertAndReadFromDB(responseBody);
      } else {
        final errorCode = response.statusCode;
        final error = response.error;
        print("response is not successful: $errorCode / $error");
      }
    } on Exception catch (error) {
      print("error: $error");
    }
    return result;
  }

  void dispose() {
    _apiService.dispose();
  }

  Future<List<Article>> insertAndReadFromDB(responseBody) async {
//    final dao = myDatabase.newsDao;
    final articles = News.fromJson(responseBody).articles;

    //WEBから取得した記事リスト（Dartのモデルクラス：Article）をDBのテーブルクラス（Articles）に変換してDB登録・DBから取得

/*
    final articleRecords =
        await dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));
*/

    final articleRecords =
        await _dao.insertAndReadNewsFromDB(articles.toArticleRecords(articles));

    //DBから取得したデータをモデルクラスに再変換して返す
    return articleRecords.toArticles(articleRecords);
  }
}
