import 'package:flutter_test/flutter_test.dart';
import 'package:news_tdd_app/article.dart';
// import 'package:news_tdd_app/article.dart';
import 'package:news_tdd_app/news_change_notifier.dart';
import 'package:news_tdd_app/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier systemUnderTest;
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
    systemUnderTest = NewsChangeNotifier(mockNewsService);
  });

  test(
    "Initial values are correct",
    () {
      expect(systemUnderTest.articles, []);
      expect(systemUnderTest.isLoading, false);
    },
  );

  group('getArticles', () {
    final articlesFromService = [
      Article(title: "Test 1", content: "Test 1 content"),
      Article(title: "Test 2", content: "Test 2 content"),
      Article(title: "Test 3", content: "Test 3 content"),
    ];

    void arrangeNewsServiceReturn3Articles() {
      when(
        () => mockNewsService.getArticles(),
      ).thenAnswer((_) async => articlesFromService);
    }

    test(
      'gets articles using the NewsService',
      () async {
        arrangeNewsServiceReturn3Articles();
        await systemUnderTest.getArticles();
        verify(() => mockNewsService.getArticles()).called(1);
      },
    );
    test(
      '''indicates loading of data,
       sets articles to the ones from the setvice,
       indicates that data is not being loaded anymore''',
      () async {
        arrangeNewsServiceReturn3Articles();
        final future = systemUnderTest.getArticles();
        expect(systemUnderTest.isLoading, true);
        await future;
        expect(systemUnderTest.articles, articlesFromService);
        expect(systemUnderTest.isLoading, false);
      },
    );
  });
}
