import 'package:flutter/material.dart';
import 'package:news_tdd_app/news_change_notifier.dart';
import 'package:news_tdd_app/news_page.dart';
import 'package:news_tdd_app/news_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (_) => NewsChangeNotifier(NewsService()),
          child: const NewsPage(),
        ));
  }
}
  