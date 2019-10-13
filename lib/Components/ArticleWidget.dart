import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Utils/CommonUtils.dart';
import 'package:community_application/Utils/DateUtils.dart';
import 'package:community_application/Components/TextWidget.dart';
import 'package:community_application/Components/PersonaCoin.dart';
import 'package:community_application/Pages/ComponentPages/ArticleWidgetPage.dart';
import 'package:community_application/Models/Person.dart';
import 'package:community_application/Models/Article.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Store/Actions.dart';

class ArticleWidgetContainer extends StatelessWidget {
  final Article article;
  final int numberOfLinesOnMinimized;

  ArticleWidgetContainer({Key key, this.article, this.numberOfLinesOnMinimized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store, article);
      },
      builder: (context, vm) {
        return ArticleWidget(
          title: article.title,
          date: article.date,
          author: article.author,
          article: article.content,
          numberOfLinesOnMinimized: numberOfLinesOnMinimized,
          callback: vm.callback,
        );
      },
    );
  }
}

class ArticleWidget extends StatelessWidget {
  ArticleWidget(
      {Key key,
      this.title,
      this.date,
      this.author,
      this.article,
      this.numberOfLinesOnMinimized = 2,
      this.callback})
      : super(key: key);

  final String title;
  final DateTime date;
  final Person author;
  final String article;
  final int numberOfLinesOnMinimized;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    void _openArticle() {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return ArticleWidgetPage(
              title: title,
              date: date,
              author: author,
              article: article,
            );
          },
        ),
      );
    }

    void _onArticleSelected() {
      _openArticle();
      callback();
    }

    return new Card(
      color: Theme.of(context).backgroundColor,
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      elevation: 0,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: _onArticleSelected,
        child: Container(
          padding: const EdgeInsets.all(paddingFromWalls),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    "${presentationFullDayFormat(date)}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                  new Row(
                    children: <Widget>[
                      new PersonaCoin(person: author, diameter: 20.0),
                      new Text(
                        author.name,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  ),
                ],
              ),
              new Padding(
                padding: EdgeInsets.all(dividerPadding),
              ),
              new Text(
                title,
                style: Theme.of(context).textTheme.headline,
              ),
              new Padding(
                padding: EdgeInsets.all(dividerPadding / 3),
              ),
              // article
              ifStringEmptyOrNull(article)
                  ? null
                  : new TextWidget(
                      text: article,
                      numberOfMinimalLines: numberOfLinesOnMinimized ?? 2,
                      expanded: false,
                      textStyle: Theme.of(context).textTheme.body2,
                    ),
            ].where(ifObjectIsNotNull).toList(),
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function callback;

  _ViewModel({
    @required this.callback,
  });

  factory _ViewModel.from(Store<AppState> store, Article article) {
    return _ViewModel(
      callback: () => store.dispatch(ArticleSelectedAction(article)),
    );
  }
}
