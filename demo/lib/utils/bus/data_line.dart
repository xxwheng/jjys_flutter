import 'package:demo/common/common.dart';
import 'package:demo/components/empty/loading_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';



/* 数据流状态 无状态  加载中  空数据  成功  失败*/
enum LineState {
  none,
  loading,
  empty,
  success,
  failure,
}

/* 数据流包 */
class LineModel<T> {
  LineState state;
  T data;

  LineModel(this.state, this.data);
}

/* Stream 局部刷新 */
class SingleDataLine<T> {
  StreamController<LineModel> _stream;

  LineModel<T> model;

  SingleDataLine([T initData]) {
    model = LineModel<T>(initData == null ? LineState.none : LineState.success, initData);
    _stream = initData ==  null ? BehaviorSubject<LineModel<T>>() : BehaviorSubject<LineModel<T>>.seeded(model);
  }

  Stream<LineModel<T>> get outer => _stream.stream;

  StreamSink<LineModel<T>> get inner => _stream.sink;

  bool get isClosed => _stream.isClosed;

  void onLoading() {
    model.state = LineState.loading;
    inner.add(model);
  }

  void setState(LineState state) {
    if (state == model.state) return;
    model.state = state;
    inner.add(model);
    print("setState更新");
  }

  void setData(T t) {
    if (t == model.data) return;

    if (_stream.isClosed) return;

    model.data = t;
    model.state = LineState.success;
    inner.add(model);
    print("更新setData");
  }

  Widget addObserver({Widget Function(BuildContext context, T data, Widget child) builder, Widget child, VoidCallback onRefresh}) {
    return DataObserverWidget<T>(this, builder, child, onRefresh);
  }

  void dispose() {
    _stream.close();
  }
}

class DataObserverWidget<T> extends StatefulWidget {


  final SingleDataLine<T> _dataLine;
  final Widget Function(BuildContext context, T data, Widget child) _builder;
  final VoidCallback onRefresh;
  final Widget child;
  DataObserverWidget(this._dataLine, this._builder, this.child, this.onRefresh);

  @override
  _DataObserverWidgetState<T> createState() => _DataObserverWidgetState<T>();
}

class _DataObserverWidgetState<T> extends State<DataObserverWidget<T>> {

  void onErrorTap() {
    if (widget._dataLine.model.data == null) {
      widget._dataLine.onLoading();
    }
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineModel<T>>(
      stream: widget._dataLine.outer,

      builder: (BuildContext context, AsyncSnapshot<LineModel<T>> snapshot) {
        if (snapshot != null && snapshot.data != null) {
          switch (snapshot.data.state) {
            case LineState.none:
              return Row();
              break;
            case LineState.empty:
              return Center(child: Text("暂无数据"),);
              break;
            case LineState.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case LineState.success:
              print("数据更新");
              return widget._builder(context, snapshot.data.data, widget.child);
              break;
            case LineState.failure:
              return GestureDetector(child: Center(child: Text("加载失败,请点击重试"),), onTap: onErrorTap) ;
              break;
            default:
              return Row();
              break;
          }
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
