import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/store/selectors.dart';
import 'package:service_application/store/state.dart';
import 'package:service_application/pages/feed_page.dart';
import 'package:service_application/pages/calendar_page.dart';
import 'package:service_application/pages/sermon_page.dart';
import 'package:service_application/store/actions.dart';

class AppPageContainer extends StatelessWidget {
  AppPageContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return AppPage(
          isAppOnDarkTheme: vm.currentIsOnDarkMode,
          switchThemes: vm.setNewIsOnDarkMode,
        );
      },
    );
  }
}

class AppPage extends StatefulWidget {
  final bool isAppOnDarkTheme;
  final Function switchThemes;

  AppPage(
      {Key key, @required this.isAppOnDarkTheme, @required this.switchThemes})
      : super(key: key);

  @override
  _AppPage createState() => new _AppPage();
}

class _AppPage extends State<AppPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Icon currentThemeIcon = Icon(Icons.brightness_2);
    if (widget.isAppOnDarkTheme) {
      currentThemeIcon = Icon(Icons.brightness_5);
    }

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
            new Tab(icon: Icon(Icons.event), text: "Calendar"),
            new Tab(icon: Icon(Icons.local_library), text: "Sermons"),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new FeedPageContainer(),
          new CalendarPageContainer(),
          new SermonPageContainer(),
        ],
      ),
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            /** Header */
            UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text("Victory Chapel Mobile"),
            ),
            /** Menu Items */
            new Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.home),
                  ),
                ],
              ),
            ),
            /** Bottom Row */
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /** Settings Button */
                new FlatButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.settings),
                    label: Text("Settings")),
                /** Theme Switch Button */
                new IconButton(
                  icon: currentThemeIcon,
                  tooltip: 'Switch Themes',
                  onPressed: () {
                    widget.switchThemes(!widget.isAppOnDarkTheme);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final bool currentIsOnDarkMode;
  final Function setNewIsOnDarkMode;

  _ViewModel({
    @required this.currentIsOnDarkMode,
    @required this.setNewIsOnDarkMode,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
        currentIsOnDarkMode: isOnDarkThemeSelector(store.state),
        setNewIsOnDarkMode: (bool newIsOnDarkTheme) =>
            store.dispatch(new SwitchThemesAction(newIsOnDarkTheme)));
  }
}
