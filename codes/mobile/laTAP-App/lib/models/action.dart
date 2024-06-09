class Action{
  int? id;
  late String actionType;
  String? locationFilter;
  String? timeFilter;
  String? objectFilter;

  Action({
    this.id,
    required this.actionType,
    this.locationFilter,
    this.timeFilter,
    this.objectFilter,
  });

  Action.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionType = json['actionType'];
    locationFilter = json['locationFilter'];
    timeFilter = json['timeFilter'];
    objectFilter = json['objectFilter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['actionType'] = actionType;
    data['locationFilter'] = locationFilter;
    data['timeFilter'] = timeFilter;
    data['objectFilter'] = objectFilter;
    return data;
  }
}