import 'package:flutter/material.dart';
import 'package:news_tdd_app/article.dart';
import 'package:news_tdd_app/article_page.dart';
import 'package:news_tdd_app/news_change_notifier.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Article>> articleFuture;

  @override
  void initState() {
    super.initState();
    articleFuture = context.read<NewsChangeNotifier>().getArticles();
    // Future.microtask(() => context.read<NewsChangeNotifier>().getArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Letters"),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error);
          }

          // print(snapshot.data);
          return ListView.builder(
            itemCount: (snapshot.data as List<Article>).length,
            itemBuilder: (context, index) {
              final article = (snapshot.data as List<Article>)[index];
              return Card(
                // color: Colors.black,
                elevation: 2,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticlePage(article: article),
                    ),
                  ),
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(
                      article.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
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
