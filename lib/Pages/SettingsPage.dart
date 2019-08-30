import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Store/Selectors.dart';
import 'package:service_application/Store/State.dart';

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
    return new Scaffold(
      appBar: new AppBar(),
      body: new ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return new Text("${widget.currentTheme}");
        },
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
