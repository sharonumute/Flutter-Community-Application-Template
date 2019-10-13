import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/Components/WidgetMonthYearBucket.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Store/Selectors.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

class ArticlePageContainer extends StatelessWidget {
  final String searchValue;

  ArticlePageContainer({Key key, this.searchValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return ArticlePage(
          articles: vm.articles,
          searchValue: searchValue,
        );
      },
    );
  }
}

class ArticlePage extends StatefulWidget {
  final List<Article> articles;
  final String searchValue;

  ArticlePage({Key key, @required this.articles, this.searchValue})
      : super(key: key);

  @override
  _ArticlePageState createState() => new _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    // Get Widgets of Articles in monthYear buckets
    Map<DateTime, List<Widget>> monthYearWidgets = getMonthYearBucketOrder(
        widget.articles,
        filterTitleBy: widget.searchValue);

    // Get iterable list of month year pairs
    List<DateTime> monthYears = monthYearWidgets.keys.toList();

    return new Scaffold(
      body: new ListView.builder(
        padding: const EdgeInsets.only(top: paddingFromWalls),
        itemCount: monthYearWidgets.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime monthYear = monthYears[index];
          return new WidgetMonthYearBucket(
              date: monthYear, items: monthYearWidgets[monthYear]);
        },
      ),
    );
  }
}

class _ViewModel {
  final List<Article> articles;

  _ViewModel({
    @required this.articles,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final articles = articlesSelector(store.state);

    return _ViewModel(
      articles: articles,
    );
  }
}
