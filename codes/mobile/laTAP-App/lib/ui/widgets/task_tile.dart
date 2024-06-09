import 'dart:math';
import 'package:latape_app/models/action.dart' as latapeAction;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latape_app/models/event.dart';
import 'package:latape_app/models/task.dart';
import 'package:latape_app/theme/theme.dart';
import 'package:latape_app/utils/util.dart';
import 'package:logger/logger.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    
  
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(Random().nextInt(4))
        ),
        child: Row(
  children: [
    Icon(
      Icons.app_registration,
      color: Colors.white,
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IF',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            _buildEventString(task!.events),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            'THEN',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            _buildActionString(task!.actions),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    ),
  ],
)

      ),
    );
  }

  String _buildEventString(List<Event> events) {
    return events.map((event) {
      String eventType = event.eventType ?? "";
      String filters = buildEventFilters(event);
      return "$eventType$filters";
    }).join(', ');
  }

  String _buildActionString(List<latapeAction.Action> actions) {
    return actions.map((action) {
      String actionType = action.actionType ?? "";
      String filters = buildActionFilters(action);
      return "$actionType$filters";
    }).join(', ');
  }
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishColor;
      case 1:
        return pinkColor;
      case 2:
        return lightBluishColor;
      default:
        return greenColor;
    }
  }
}
