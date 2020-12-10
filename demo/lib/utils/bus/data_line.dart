import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

/* Stream 局部刷新 */
class SingleDataLine<T> {
  StreamController<T> _stream;

  T currentData;

  SingleDataLine([T initData]) {
    currentData = initData;
    _stream = initData ==  null ? BehaviorSubject<T>() : BehaviorSubject<T>.seeded(initData);
  }

  Stream<T> get outer => _stream.stream;

  StreamSink<T> get inner => _stream.sink;

  void setData(T t) {
    if (t == currentData) return;

    if (_stream.isClosed) return;

    currentData = t;

    inner.add(t);
  }

  Widget addObserver(Widget Function(BuildContext context, T data) observer) {
    return DataObserverWidget<T>(this, observer);
  }

  void dispose() {
    _stream.close();
  }
}

class DataObserverWidget<T> extends StatefulWidget {


  final SingleDataLine _dataLine;
  final Widget Function(BuildContext context, T data) _builder;
  DataObserverWidget(this._dataLine, this._builder);

  @override
  _DataObserverWidgetState<T> createState() => _DataObserverWidgetState<T>();
}

class _DataObserverWidgetState<T> extends State<DataObserverWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: widget._dataLine.outer,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot != null && snapshot.data != null) {
          return widget._builder(context, snapshot.data);
        } else {
          return Row();
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget._dataLine.dispose();
  }
}
