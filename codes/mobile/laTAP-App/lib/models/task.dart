import 'package:latape_app/models/action.dart';
import 'package:latape_app/models/event.dart';

class Task {
  int? id;
  List<Event> events = [];
  List<Action> actions = [];
  String? createdAt;
  String? repeat;

  Task({
    this.id,
    this.createdAt,
    this.repeat,
    required this.events,
    required this.actions,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    events = (json['events'] as List).map((e) => Event.fromJson(e)).toList();
    actions = (json['actions'] as List).map((a) => Action.fromJson(a)).toList();
    createdAt = json['createdAt'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['events'] = events.map((e) => e.toJson()).toList();
    data['actions'] = actions.map((a) => a.toJson()).toList();
    data['createdAt'] = createdAt;
    data['repeat'] = repeat;
    return data;
  }
}
