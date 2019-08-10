import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/store/selectors.dart';
import 'package:service_application/store/state.dart';

class SettingPageContainer extends StatelessWidget {
  SettingPageContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return SettingPage(
          currentIsOnDarkMode: vm.currentIsOnDarkMode,
        );
      },
    );
  }
}

class SettingPage extends StatefulWidget {
  final bool currentIsOnDarkMode;

  SettingPage({
    Key key,
    @required this.currentIsOnDarkMode,
  }) : super(key: key);

  @override
  _SettingPageState createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return new Text("${widget.currentIsOnDarkMode}");
        },
      ),
    );
  }
}

class _ViewModel {
  final bool currentIsOnDarkMode;

  _ViewModel({
    @required this.currentIsOnDarkMode,
  });

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(
      currentIsOnDarkMode: isOnDarkThemeSelector(store.state),
    );
  }
}
