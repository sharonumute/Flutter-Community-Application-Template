import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/App.dart';
import 'package:service_application/Store/State.dart';
import 'package:service_application/Store/Reducers.dart';
import 'package:service_application/Store/Actions.dart';
import 'package:service_application/Globals/Themes.dart';
import 'package:service_application/Utils/PreferenceUtils.dart';

void main() {
  final store = new Store<AppState>(appReducer, initialState: new AppState());
  runApp(new AppStoreContainer(
    store: store,
  ));
}

class AppStoreContainer extends StatelessWidget {
  final Store<AppState> store;

  AppStoreContainer({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MainAppContainer(),
    );
  }
}

class MainAppContainer extends StatelessWidget {
  MainAppContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return MainApp(
          store: vm.store,
        );
      },
    );
  }
}

class MainApp extends StatefulWidget {
  final Store<AppState> store;

  MainApp({Key key, this.store}) : super(key: key);

  @override
  _MainAppState createState() => new _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Victory Chapel Mobile',
      theme: widget.store.state.isOnDarkTheme ? darkTheme : lightTheme,
      home: new StoreBuilder<AppState>(
        onInit: (store) {
          store.dispatch(new FetchEventsAction(store));
          store.dispatch(new FetchCalendarEventsAction(store));
          store.dispatch(new FetchSermonsAction(store));
          store.dispatch(new SetCurrentSelectedCalendarAction(
              (new DateTime.now()).toString()));
          getIsOnDarkTheme().then((isOnDarkTheme) {
            store.dispatch(new SwitchThemesAction(isOnDarkTheme));
          });
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
            return new AppPageContainer();
          }
        },
      ),
    );
  }
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel({@required this.store});

  factory _ViewModel.from(Store<AppState> store) {
    return _ViewModel(store: store);
  }
}
