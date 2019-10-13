import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:community_application/App.dart';
import 'package:community_application/Store/State.dart';
import 'package:community_application/Store/Reducers.dart';

void main() {
  final store = new Store<AppState>(appReducer, initialState: new AppState());
  runApp(new StorePasserContainer(
    store: store,
  ));
}

class StorePasserContainer extends StatelessWidget {
  final Store<AppState> store;

  StorePasserContainer({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new AppContainer(),
    );
  }
}
