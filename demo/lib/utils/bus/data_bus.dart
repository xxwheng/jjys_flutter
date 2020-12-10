import 'package:demo/utils/bus/data_line.dart';

/* 多个Stream的绑定 */
mixin MultiDataLine {

  final Map<String, SingleDataLine> dataBus = Map();

  SingleDataLine<T> getLine<T>(String key, {T initValue}) {
    if (!dataBus.containsKey(key)) {
      SingleDataLine<T> dataLine = SingleDataLine<T>(initValue);
      dataBus[key] = dataLine;
    }
    return dataBus[key];
  }

  void dataBusDispose() {
    print("销毁dataBus");
    dataBus.values.forEach((e) => e.dispose());
    dataBus.clear();
  }
}