import 'package:get/get.dart';
import 'package:latape_app/models/action.dart';

// 创建 ActionController 类
class ActionController extends GetxController {
  // 使用 RxList 使 actionList 变为响应式列表
  var actionList = <Action>[].obs;

  // 添加事件
  void addAction(Action action) {
    actionList.add(action);
  }

  // 获取所有事件
  List<Action> getActions() {
    return actionList;
  }

  // 删除事件
  void deleteAction(int id) {
    actionList.removeWhere((action) => action.id == id);
  }

  // 更新事件
  void updateAction(Action updatedAction) {
    int index = actionList.indexWhere((action) => action.id == updatedAction.id);
    if (index != -1) {
      actionList[index] = updatedAction;
    }
  }
}
