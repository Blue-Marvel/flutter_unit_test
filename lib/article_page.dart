import 'package:flutter/material.dart';
import 'package:news_tdd_app/article.dart';

class ArticlePage extends StatefulWidget {
  final Article article;
  const ArticlePage({required this.article, super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text(
              widget.article.title,
              style: Theme.of(context).textTheme.headlineMedium ,
            ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mq.padding.top,
          bottom: mq.padding.bottom,
          left: 8,
          right: 8,
        ),
        child: Text(widget.article.content),
      ),
    );
  }
}
