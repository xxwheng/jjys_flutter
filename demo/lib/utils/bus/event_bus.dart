
typedef void EventCallback(arg);

EventBus eventBus = EventBus();

class EventBus {

  EventBus._internal();

  static EventBus _singleton = EventBus._internal();

  factory EventBus() => _singleton;

  ///  事件map 一对多的关系 所以用list保存
  var _eMap = Map<Object, List<EventCallback>>();

  /// 事件监听
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;

    _eMap[eventName] ??= List<EventCallback>();
    _eMap[eventName].add(f);
  }

  /// 触发eventCallback  arg可选参数
  void emit(eventName, [arg]) {
    var list = _eMap[eventName];
    if (list == null || list.isEmpty) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }

  /// 移除监听
  void off(eventName, [EventCallback f]) {
    var list = _eMap[eventName];
    if (list == null || list.isEmpty) return;
    if (f == null) {
      _eMap[eventName] = null;
    } else {
      list.remove(f);
      if (list.isEmpty) {
        _eMap[eventName] = null;
      }
    }
  }
}