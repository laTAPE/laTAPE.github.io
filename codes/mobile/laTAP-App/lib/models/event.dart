class Event{
  int? id;
  late String eventType;
  String? locationFilter;
  String? timeFilter;
  String? objectFilter;

  Event({
    this.id,
    required this.eventType,
    this.locationFilter,
    this.timeFilter,
    this.objectFilter,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventType = json['eventType'];
    locationFilter = json['locationFilter'];
    timeFilter = json['timeFilter'];
    objectFilter = json['objectFilter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eventType'] = eventType;
    data['locationFilter'] = locationFilter;
    data['timeFilter'] = timeFilter;
    data['objectFilter'] = objectFilter;
    return data;
  }
}