import 'package:community_application/Strings/WidgetTexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/Store/Selectors.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Pages/HomepageTabPages/FeedPage.dart';
import 'package:community_application/Pages/HomepageTabPages/CalendarPage.dart';
import 'package:community_application/Pages/HomepageTabPages/ArticlePage.dart';
import 'package:community_application/Pages/Routes.dart';
import 'package:community_application/Store/Actions.dart';
import 'package:community_application/Globals/Themes.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Utils/PreferenceUtils.dart';
import 'package:community_application/Strings/AppDetails.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

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
          currentTheme: vm.currentTheme,
          setSelectedTheme: vm.setSelectedTheme,
          isLoading: vm.isLoading,
          onAppStarted: vm.onAppStarted,
        );
      },
    );
  }
}

class App extends StatefulWidget {
  final String currentTheme;
  final Function setSelectedTheme;
  final bool isLoading;
  final Function onAppStarted;

  App(
      {Key key,
      @required this.currentTheme,
      @required this.setSelectedTheme,
      @required this.isLoading,
      @required this.onAppStarted})
      : super(key: key);

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  // controls the text label we use as a search bar
  TextEditingController _filter = new TextEditingController();
  TabController _tabController;
  String _searchValue = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text(COMMUNITY_NAME);

  @override
  void initState() {
    super.initState();
    widget.onAppStarted();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    _searchValue = "";

    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchValue = "";
        });
      } else {
        setState(() {
          _searchValue = _filter.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBar = new Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: new TextField(
        controller: _filter,
        style: TextStyle(
          color: normalBlackText,
        ),
        keyboardAppearance: Theme.of(context).brightness,
        cursorColor: normalBlackText,
        decoration: new InputDecoration(
          prefixIcon: new Icon(
            Icons.search,
            color: normalBlackText,
          ),
          hintText: SEARCH_HINT,
          filled: true,
          fillColor: dafaultWhite,
          labelStyle: TextStyle(
            color: normalBlackText,
          ),
          hintStyle: TextStyle(
            color: helperBlackText,
          ),
          helperStyle: TextStyle(
            color: helperBlackText,
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(500)),
            gapPadding: 0,
          ),
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );

    void _onSearch() {
      setState(() {
        if (this._searchIcon.icon == Icons.search) {
          this._searchIcon = new Icon(Icons.close);
          this._appBarTitle = searchBar;
        } else {
          this._searchIcon = new Icon(Icons.search);
          this._appBarTitle = new Text(COMMUNITY_NAME);
          _filter.clear();
        }
      });
    }

    Icon currentThemeIcon = Icon(Icons.brightness_2);
    bool isCurrentlyOnADarkTheme = false;
    if (DARK_THEMES.contains(widget.currentTheme)) {
      currentThemeIcon = Icon(Icons.brightness_5);
      isCurrentlyOnADarkTheme = true;
    }

    Map<Widget, Widget> homepageTabs = {
      new Tab(icon: Icon(Icons.rss_feed), text: FEED_TAB):
          new FeedPageContainer(searchValue: _searchValue),
      new Tab(icon: Icon(Icons.event), text: CALENDAR_TAB):
          new CalendarPageContainer(searchValue: _searchValue),
      new Tab(icon: Icon(Icons.local_library), text: ARTICLE_TAB):
          new ArticlePageContainer(searchValue: _searchValue),
    };

    Widget drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(""),
      accountEmail: Text(APP_NAME),
    );

    return new MaterialApp(
      title: APP_NAME,
      theme: allThemes[widget.currentTheme],
      routes: routes,
      home: Builder(
        builder: (context) {
          if (widget.isLoading) {
            return loadingScreen;
          } else {
            return new Scaffold(
              appBar: new AppBar(
                centerTitle: true,
                title: _appBarTitle,
                bottom: new TabBar(
                  controller: _tabController,
                  labelStyle: Theme.of(context).textTheme.subhead,
                  unselectedLabelStyle: Theme.of(context).textTheme.subhead,
                  tabs: homepageTabs.keys.toList(),
                ),
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    icon: _searchIcon,
                    onPressed: _onSearch,
                    tooltip: MaterialLocalizations.of(context).searchFieldLabel,
                  ),
                ],
              ),
              body: new TabBarView(
                controller: _tabController,
                children: homepageTabs.values.toList(),
              ),
              drawer: Drawer(
                child: new Column(
                  children: <Widget>[
                    drawerHeader,
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
                          tooltip: 'Switch Between Light and Dark themes',
                          onPressed: () => widget.setSelectedTheme(
                              isCurrentlyOnADarkTheme
                                  ? LIGHT_BLUE
                                  : DARK_BLACK),
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
  final String currentTheme;
  final Function setSelectedTheme;
  final bool isLoading;
  final Function onAppStarted;

  _ViewModel({
    @required this.currentTheme,
    @required this.setSelectedTheme,
    @required this.isLoading,
    @required this.onAppStarted,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
        currentTheme: currentThemeSelector(store.state),
        setSelectedTheme: (String newTheme) =>
            store.dispatch(new ChangeThemesAction(newTheme)),
        isLoading: store.state.isLoading,
        onAppStarted: () {
          store.dispatch(new FetchEventsAction(store));
          store.dispatch(new FetchArticlesAction(store));
          store.dispatch(new SetCurrentSelectedCalendarDateAction(
              (new DateTime.now()).toString()));
          getCurrentTheme().then((currentSavedTheme) {
            store.dispatch(new ChangeThemesAction(currentSavedTheme));
          });
        });
  }
}
