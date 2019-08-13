import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Store/Selectors.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Pages/HomepageTabPages/FeedPage.dart';
import 'package:service_application/Pages/HomepageTabPages/CalendarPage.dart';
import 'package:service_application/Pages/HomepageTabPages/SermonPage.dart';
import 'package:service_application/Pages/Routes.dart';
import 'package:service_application/Store/Actions.dart';
import 'package:service_application/Globals/Themes.dart';
import 'package:service_application/Utils/PreferenceUtils.dart';
import 'package:service_application/Constants/AppDetails.dart';

class AppContainer extends StatelessWidget {
  AppContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return App(
          isOnDarkTheme: vm.isOnDarkTheme,
          setNewIsOnDarkTheme: vm.setNewIsOnDarkMode,
          isLoading: vm.isLoading,
          onAppStarted: vm.onAppStarted,
        );
      },
    );
  }
}

class App extends StatefulWidget {
  final bool isOnDarkTheme;
  final Function setNewIsOnDarkTheme;
  final bool isLoading;
  final Function onAppStarted;

  App(
      {Key key,
      @required this.isOnDarkTheme,
      @required this.setNewIsOnDarkTheme,
      @required this.isLoading,
      @required this.onAppStarted})
      : super(key: key);

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    widget.onAppStarted();
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
    if (widget.isOnDarkTheme) {
      currentThemeIcon = Icon(Icons.brightness_5);
    }

    return new MaterialApp(
      title: 'Victory Chapel Mobile',
      theme: widget.isOnDarkTheme ? darkTheme : lightTheme,
      routes: routes,
      home: Builder(
        builder: (context) {
          if (widget.isLoading) {
            return new Scaffold(
              body: new Center(
                child: new CircularProgressIndicator(),
              ),
            );
          } else {
            return new Scaffold(
              appBar: new AppBar(
                centerTitle: true,
                title: new Text(
                  APP_TITLE_BAR,
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
                      accountEmail: Text(APP_NAME),
                    ),
                    /** Menu Items */
                    new Expanded(
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text("About"),
                            leading: Icon(Icons.info),
                            onTap: () =>
                                Navigator.of(context).pushNamed(ABOUT_PAGE),
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
                            onPressed: () =>
                                Navigator.of(context).pushNamed(SETTINGS_PAGE),
                            icon: Icon(Icons.settings),
                            label: Text("Settings")),
                        /** Theme Switch Button */
                        new IconButton(
                          icon: currentThemeIcon,
                          tooltip: 'Switch Themes',
                          onPressed: () =>
                              widget.setNewIsOnDarkTheme(!widget.isOnDarkTheme),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class _ViewModel {
  final bool isOnDarkTheme;
  final Function setNewIsOnDarkMode;
  final bool isLoading;
  final Function onAppStarted;

  _ViewModel({
    @required this.isOnDarkTheme,
    @required this.setNewIsOnDarkMode,
    @required this.isLoading,
    @required this.onAppStarted,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
        isOnDarkTheme: isOnDarkThemeSelector(store.state),
        setNewIsOnDarkMode: (bool newIsOnDarkTheme) =>
            store.dispatch(new SwitchThemesAction(newIsOnDarkTheme)),
        isLoading: store.state.isLoading,
        onAppStarted: () {
          store.dispatch(new FetchEventsAction(store));
          store.dispatch(new FetchCalendarEventsAction(store));
          store.dispatch(new FetchSermonsAction(store));
          store.dispatch(new SetCurrentSelectedCalendarAction(
              (new DateTime.now()).toString()));
          getIsOnDarkTheme().then((isOnDarkTheme) {
            store.dispatch(new SwitchThemesAction(isOnDarkTheme));
          });
        });
  }
}
