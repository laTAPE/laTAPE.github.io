
import 'package:get/get.dart';
import 'package:latape_app/models/event.dart';

// 创建 EventController 类
class EventController extends GetxController {
  // 使用 RxList 使 eventList 变为响应式列表
  var eventList = <Event>[].obs;

  // 添加事件
  void addEvent(Event event) {
    eventList.add(event);
  }

  // 获取所有事件
  List<Event> getEvents() {
    return eventList;
  }

  // 删除事件
  void deleteEvent(int id) {
    eventList.removeWhere((event) => event.id == id);
  }

  // 更新事件
  void updateEvent(Event updatedEvent) {
    int index = eventList.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      eventList[index] = updatedEvent;
    }
  }
}
