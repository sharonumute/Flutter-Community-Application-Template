import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:service_application/globals.dart' as global;
import 'package:service_application/store/selectors.dart';
import 'package:service_application/store/state.dart';
import 'package:service_application/utils/widgetUtils.dart';
import 'package:service_application/reusable_widgets/sermon_item.dart';

class SermonPageConatiner extends StatelessWidget {
  SermonPageConatiner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) {
        return _ViewModel.from(store);
      },
      builder: (context, vm) {
        return SermonPage(
          sermons: vm.sermons,
        );
      },
    );
  }
}

class SermonPage extends StatefulWidget {
  final List<SermonObject> sermons;

  SermonPage({Key key, @required this.sermons}) : super(key: key);

  @override
  _SermonPageState createState() => new _SermonPageState();
}

class _SermonPageState extends State<SermonPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        padding: const EdgeInsets.all(global.marginpaddingFromScreenHover),
        itemCount: widget.sermons.length,
        itemBuilder: (BuildContext context, int index) {
          return new SermonItemConatiner(sermon: widget.sermons[index]);
        },
      ),
    );
  }
}

class _ViewModel {
  final List<SermonObject> sermons;

  _ViewModel({
    @required this.sermons,
  });

  factory _ViewModel.from(Store<AppState> store) {
    final sermons = sermonsSelector(store.state);

    return _ViewModel(
      sermons: sermons,
    );
  }
}
