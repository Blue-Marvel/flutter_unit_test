import 'package:flutter/material.dart';
import 'package:news_tdd_app/article_page.dart';
import 'package:news_tdd_app/news_change_notifier.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NewsChangeNotifier>().getArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Letters"),
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (BuildContext context, notifier, Widget? child) {
          if (notifier.isLoading) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return ListView.builder(
            itemCount: notifier.articles.length,
            itemBuilder: (context, index) {
              final article = notifier.articles[index];
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticlePage(article: article),
                    ),
                  ),
                  child: ListTile(
                      title: Text(article.title),
                      subtitle: Text(article.content, maxLines: 4, overflow: TextOverflow.ellipsis,),
                  ),
                ),
              );
            },
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
          );
        },
      ),
    );
  }
}
