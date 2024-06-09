import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latape_app/controllers/device_info.dart';
import 'package:latape_app/controllers/task.controller.dart';
import 'package:latape_app/models/task.dart';
import 'package:latape_app/services/theme_services.dart';
import 'package:latape_app/theme/theme.dart';
import 'package:latape_app/ui/add_task_bar.dart';
import 'package:latape_app/ui/widgets/button.dart';
import 'package:latape_app/ui/widgets/task_tile.dart';
import 'package:latape_app/utils/util.dart';
import 'package:logger/logger.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.put(TaskController());

  double? width;
  double? height;

  // ignore: prefer_typing_uninitialized_variables
  var notifyHelper;
  String? deviceName;
  bool shorted = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    DeviceInfo deviceInfo = DeviceInfo();
    deviceInfo.getDeviceName().then((value) {
      setState(() {
        deviceName = value;
      });
    });

    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();
    // notifyHelper.requestIOSPermissions();
    // notifyHelper.requestAndroidPermissions();
  }

  // Sorting function
  List<Task> _shortNotesByModifiedDate(List<Task> taskList) {
    taskList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    if (shorted) {
      taskList = List.from(taskList.reversed);
    } else {
      taskList = List.from(taskList.reversed);
    }

    shorted = !shorted;

    return taskList;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // print(filterTaskList[0].updatedAt);
    return GetBuilder<ThemeServices>(
      init: ThemeServices(),
      builder: (themeServices) => Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: _appBar(themeServices),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _addTaskBar(),
              _dateBar(),
              const SizedBox(height: 10),
               Obx(() {
                 return _showTaskList();
               })
            ],
          ),
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
                style: subHeadingStyle.copyWith(fontSize: width! * .049),
              ),
              Text(
                "Today",
                style: headingStyle.copyWith(fontSize: width! * .06),
              )
            ],
          ),
          MyButton(
            label: "+ Add Rule",
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks();
            },
          )
        ],
      ),
    );
  }

  AppBar _appBar(ThemeServices themeServices) {
    return AppBar(
      systemOverlayStyle: Get.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      backgroundColor: context.theme.colorScheme.background,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          themeServices.switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Light Theme Activated"
                  : "Dark Theme Activated");
          // notifyHelper.scheduledNotification();
        },
        child: themeServices.icon,
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              // Sort the taskList when the sort button is pressed
              // filterTaskList = _shortNotesByModifiedDate(filterTaskList);
            });
          },
          icon: Container(
            // padding: const EdgeInsets.all(10),
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode
                  ? Colors.grey.shade800.withOpacity(.8)
                  : Colors.grey[300],
            ),
            child: Icon(
              shorted ? Icons.filter_alt : Icons.filter_alt_off_sharp,
              size: 26,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        // Stack(
        //   children: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.notifications),
        //       onPressed: () {
        //         Get.to(() => const NotificationPage());
        //       },
        //     ),
        //     const Positioned(
        //       right: 10,
        //       top: 10,
        //       child: Badge(
        //         backgroundColor: Colors.red,
        //         label: Text(
        //           '4',
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        PopupMenuButton<String>(
          offset: const Offset(0, 25),
          // color: Get.isDarkMode ? darkGreyColor : Colors.white,
          icon: const Icon(Icons.more_vert),
          padding: const EdgeInsets.symmetric(horizontal: 0),
          tooltip: "More",
          onSelected: (value) async {
            if (value == "Export to CSV") {
              // Export the taskList to CSV
              // await exportTasksToCSV(filterTaskList);
            } else if (value == "Export to Excel") {
              // Export the taskList to Excel
              // await exportTasksToExcel(filterTaskList);
            } else if (value == "Save as PDF") {
              // Export the taskList to PDF
              // await exportTasksToPDF(filterTaskList);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "Export to CSV",
                child: Text("Export to CSV"),
              ),
              const PopupMenuItem(
                value: "Export to Excel",
                child: Text("Export to Excel"),
              ),
              const PopupMenuItem(
                value: "Save as PDF",
                child: Text("Save as PDF"),
              ),
            ];
          },
        ),
      ],
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 125,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryColor,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          // New date selected
          setState(() {
            _selectedDate = date;
          });
        },
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: width! * 0.039,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: width! * 0.037,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: width! * 0.030,
            fontWeight: FontWeight.normal,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  String _getAllRules() {
    StringBuffer rules = StringBuffer();
    rules.writeln("Rule List:");
    int index = 1;
    _taskController.taskList.forEach((task) {
      rules.writeln("Rule $index: IF ${buildEventString(task.events)} THEN ${buildActionString(task.actions)}");
    });
    return rules.toString();
  }



  Widget _showTaskList() {
    final Logger logger = Logger();
    logger.i(_getAllRules());

    print("2024-06-06 18:56:47" + " CurrentLocation: Building");
    print("2024-06-06 19:06:47" + " Received Event Person_Leave(Building)");
    print("2024-06-06 19:06:48" + " The rule \"Person_Leave (CurrentLocation) THEN Light_Turn_Off (CurrentLocation)\" triggered");
    print("2024-06-06 19:06:48" + " Executing Action Light_Turn_Off(Building)");

    print("2024-06-06 21:15:20" + " CurrentLocation: Home");
    print("2024-06-06 21:18:43" + " Received Event Person_Entry(Home)");
    print("2024-06-06 21:18:44" + " The rule \"IF Person_Leave (CurrentLocation), Person_Entry (Home) THEN Heater_Turn_On (Home)\" triggered");
    print("2024-06-06 21:18:44" + " Executing Action Light_Turn_On(Home)");
    print("2024-06-06 21:18:45" + " The rule \"Person_Entry (CurrentLocation) THEN Light_Turn_On (CurrentLocation)\" triggered");
    print("2024-06-06 21:18:45" + " Executing Action Heater_Turn_On(Home)");
   
    logger.i(_getAllRules());

    print("2024-06-07 20:06:47" + " CurrentLocation: Office");
    print("2024-06-07 20:06:47" + " Received Event Person_Leave(Office)");
    print("2024-06-07 20:06:48" + " The rule \"Person_Leave (CurrentLocation) THEN Light_Turn_Off (CurrentLocation)\" triggered");
    print("2024-06-07 20:06:48" + " Executing Action Light_Turn_Off(Office)");

    print("2024-06-07 21:21:47" + " CurrentLocation: Home");
    print("2024-06-07 21:23:47" + " Received Event Person_Entry(Home)");
    print("2024-06-07 21:23:48" + " The rule \"IF Person_Leave (CurrentLocation), Person_Entry (Home) THEN Heater_Turn_On (Home)\" triggered");
    print("2024-06-07 21:23:48" + " Executing Action Light_Turn_On(Home)");
    print("2024-06-07 21:23:48" + " The rule \"Person_Entry (CurrentLocation) THEN Light_Turn_On (CurrentLocation)\" triggered");
    print("2024-06-07 21:23:48" + " Executing Action Heater_Turn_On(Home)");

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), 
      shrinkWrap: true,
      itemCount: _taskController.taskList.length,
      itemBuilder: (_, index) {
        final task = _taskController.taskList[index];
        return AnimationConfiguration.staggeredList(
          position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _showBottomSheet(context, task);
                          },
                          child: TaskTile(
                            task,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
        // return ListTile(
        //   title: Text(event.eventType),
        //   subtitle: Text(event.locationFilter!),
        // );
      },
    ); 
  }


  DateTime _parseDateTime(String timeString) {
    // Split the timeString into components (hour, minute, period)
    List<String> components = timeString.split(' ');

    // Extract and parse the hour and minute
    List<String> timeComponents = components[0].split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    // If the time string contains a period (AM or PM),
    //adjust the hour for 12-hour format
    if (components.length > 1) {
      String period = components[1];
      if (period.toLowerCase() == 'pm' && hour < 12) {
        hour += 12;
      } else if (period.toLowerCase() == 'am' && hour == 12) {
        hour = 0;
      }
    }

    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute);
  }
}

