import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/Globals/Themes.dart';
import 'package:community_application/Globals/Values.dart';
import 'package:community_application/Store/Selectors.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Utils/WidgetUtils.dart';

class SettingsPageContainer extends StatelessWidget {
  SettingsPageContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return SettingsPage(
          currentTheme: vm.currentTheme,
        );
      },
    );
  }
}

class SettingsPage extends StatefulWidget {
  final String currentTheme;

  SettingsPage({
    Key key,
    @required this.currentTheme,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Widget themeSetting = new Card(
      margin: const EdgeInsets.only(
          top: marginpaddingFromScreenFlat,
          bottom: marginpaddingFromScreenFlat),
      child: new Container(
        padding: const EdgeInsets.fromLTRB(paddingFromWalls, paddingFromScreen,
            paddingFromWalls, paddingFromScreen),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Themes"),
            sixPointPadding,
            new Wrap(
              spacing: marginpaddingFromScreenFlat,
              children: <Widget>[
                Chip(
                  backgroundColor: Theme.of(context).accentColor,
                  label: Text("Light Blue Theme"),
                ),
                Chip(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  label: Text(" Dark Black Theme"),
                ),
                Chip(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  label: Text("Dark Night Teal Theme"),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              pinned: true,
            ),
          ];
        },
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[themeSetting],
        ),
      ),
    );
  }
}

class _ViewModel {
  final String currentTheme;

  _ViewModel({
    @required this.currentTheme,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
      currentTheme: currentThemeSelector(store.state),
    );
  }
}
