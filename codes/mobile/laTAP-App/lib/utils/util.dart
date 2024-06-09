import 'package:latape_app/models/action.dart';
import 'package:latape_app/models/event.dart';

String buildEventFilters(Event? event) {
    List<String> filters = [];

    if (event?.locationFilter != null && event!.locationFilter!.isNotEmpty) {
      filters.add(event.locationFilter!);
    }
    if (event?.timeFilter != null && event!.timeFilter!.isNotEmpty && event.timeFilter != "None") {
      filters.add(event.timeFilter!);
    }
    if (event?.objectFilter != null && event!.objectFilter!.isNotEmpty && event.objectFilter != "None") {
      filters.add(event.objectFilter!);
    }

    return filters.isNotEmpty ? " (${filters.join(', ')})" : "";
  }

String buildActionFilters(Action? action) {
    List<String> filters = [];

    if (action?.locationFilter != null && action!.locationFilter!.isNotEmpty) {
      filters.add(action.locationFilter!);
    }
    if (action?.timeFilter != null && action!.timeFilter!.isNotEmpty && action.timeFilter != "None") {
      filters.add(action.timeFilter!);
    }
    if (action?.objectFilter != null && action!.objectFilter!.isNotEmpty && action.objectFilter != "None") {
      filters.add(action.objectFilter!);
    }

    return filters.isNotEmpty ? " (${filters.join(', ')})" : "";
  }


  String buildEventString(List<Event> events) {
    return events.map((event) {
      String eventType = event.eventType ?? "";
      String filters = buildEventFilters(event);
      return "$eventType$filters";
    }).join(', ');
  }

  String buildActionString(List<Action> actions) {
    return actions.map((action) {
      String actionType = action.actionType ?? "";
      String filters = buildActionFilters(action);
      return "$actionType$filters";
    }).join(', ');
  }