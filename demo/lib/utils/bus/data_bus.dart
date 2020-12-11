import 'package:demo/utils/bus/data_line.dart';

/* 多个Stream的绑定 */
mixin MultiDataLine {

  final Map<String, SingleDataLine> dataBus = Map();

  SingleDataLine<T> getLine<T>(String key, {T initValue}) {
    if (!dataBus.containsKey(key)) {
      SingleDataLine<T> dataLine = SingleDataLine<T>(initValue);
      dataBus[key] = dataLine;
    } else if (dataBus[key].isClosed) {
      /// 如果map中有dataline,但是dataline中的streambe已经被关闭(节点被移除)，
      /// 则 重新创建
      T origin = dataBus[key].currentData;
      SingleDataLine<T> dataLine = SingleDataLine<T>(origin);
      dataBus[key] = dataLine;
    }

    return dataBus[key];
  }

  void dataBusDispose() {
    dataBus.values.forEach((e) => e.dispose());
    dataBus.clear();
  }
}