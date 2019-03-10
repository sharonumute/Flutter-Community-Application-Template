import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/store/state.dart';
import 'package:service_application/store/reducers.dart';
import 'package:service_application/themes.dart';
import 'package:service_application/pages/feed_page.dart';
import 'package:service_application/pages/calendar_page.dart';
import 'package:service_application/pages/sermon_page.dart';
import 'package:service_application/store/actions.dart';

void main() {
  final store = new Store<AppState>(appReducer, initialState: new AppState());
  runApp(new MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Victory Chapel Mobile',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: new StoreBuilder<AppState>(
          onInit: (store) {
            store.dispatch(new FetchEventsAction(store));
            store.dispatch(new FetchCalendarEventsAction(store));
            store.dispatch(new FetchSermonsAction(store));
          },
          builder: (context, store) {
            var isLoading = store.state.isLoading;
            if (isLoading) {
              return new Scaffold(
                body: new Center(
                  child: new CircularProgressIndicator(),
                ),
              );
            } else {
              return new AppPage();
            }
          },
        ),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPage createState() => new _AppPage();
}

class _AppPage extends State<AppPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.offset = 0.5;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "Victory Chapel",
        ),
        bottom: new TabBar(
          controller: _tabController,
          labelStyle: Theme.of(context).textTheme.subhead,
          unselectedLabelStyle: Theme.of(context).textTheme.subhead,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.rss_feed), text: "Feed"),
            new Tab(icon: Icon(Icons.calendar_today), text: "Calendar"),
            new Tab(icon: Icon(Icons.local_library), text: "Sermons"),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new FeedPageConatiner(),
          new CalendarPageConatiner(),
          new SermonPageConatiner(),
        ],
      ),
    );
  }
}
