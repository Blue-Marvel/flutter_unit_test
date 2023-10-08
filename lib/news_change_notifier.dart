import 'package:flutter/material.dart';
import 'package:news_tdd_app/article.dart';
import 'package:news_tdd_app/news_service.dart';

class NewsChangeNotifier extends ChangeNotifier {
  final NewsService _newsService;
  NewsChangeNotifier(this._newsService);


  // ignore: prefer_final_fields
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  // ignore: prefer_final_fields
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    _isLoading = true;
    notifyListeners();
    _articles = await _newsService.getArticles();
    notifyListeners();
    _isLoading = false;
    notifyListeners();
    // return _articles;
  }
}
