import 'package:flutter/material.dart';

// 定义事件类
class Event {
  final String title;
  final String description;

  Event(this.title, this.description);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event List'),
        ),
        body: EventListWidget(),
      ),
    );
  }
}

class EventListWidget extends StatelessWidget {
  // 示例事件列表
  final List<Event> eventList = [
    Event('Event 1', 'Description 1'),
    Event('Event 2', 'Description 2'),
    Event('Event 3', 'Description 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.background,
      // appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _showEventList(),
            ],
          ),
        ),
    );
  }

    Widget _showEventList() {
    return Expanded(
      child:ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (_, index) {
          final event = eventList[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
          );
        },
      ),
    ); 
  }

}
