import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/Store/Selectors.dart';
import 'package:service_application/Store/State.dart';

class AboutPageContainer extends StatelessWidget {
  AboutPageContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return AboutPage(
          currentIsOnDarkMode: vm.currentIsOnDarkMode,
        );
      },
    );
  }
}

class AboutPage extends StatefulWidget {
  final bool currentIsOnDarkMode;

  AboutPage({
    Key key,
    @required this.currentIsOnDarkMode,
  }) : super(key: key);

  @override
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Text("${widget.currentIsOnDarkMode}"),
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
