
import 'package:get/get.dart';
import 'package:latape_app/models/task.dart';

// 创建 TaskController 类
class TaskController extends GetxController {
  // 使用 RxList 使 taskList 变为响应式列表
  var taskList = <Task>[].obs;

  // 添加事件
  void addTask(Task task) {
    taskList.add(task);
  }

  // 获取所有事件
  List<Task> getTasks() {
    return taskList;
  }

  // 删除事件
  void deleteTask(int id) {
    taskList.removeWhere((task) => task.id == id);
  }

  // 更新事件
  void updateTask(Task updatedTask) {
    int index = taskList.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      taskList[index] = updatedTask;
    }
  }
}
