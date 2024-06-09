import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latape_app/controllers/action.controller.dart';
import 'package:latape_app/controllers/device_info.dart';
import 'package:latape_app/controllers/event.controller.dart';
import 'package:latape_app/controllers/task.controller.dart';
import 'package:latape_app/models/action.dart' as latapeAction;
import 'package:latape_app/models/event.dart';
import 'package:latape_app/models/task.dart';
import 'package:latape_app/theme/theme.dart';
import 'package:latape_app/ui/add_action_bar.dart';
import 'package:latape_app/ui/add_event_bar.dart';
import 'package:latape_app/ui/widgets/action_tile.dart';

import 'package:latape_app/ui/widgets/button.dart';
import 'package:latape_app/ui/widgets/event_tile.dart';
import 'package:latape_app/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  final Task? task;

  const AddTaskPage({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String? deviceName;

  final TaskController _taskController = Get.find();
  final EventController eventController = Get.put(EventController());
  final ActionController actionController = Get.put(ActionController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 2)))
      .toString();
  String _endTime = DateFormat("hh:mm a")
      .format(DateTime.now().add(const Duration(minutes: 10)))
      .toString();

  List<Event> _selectedEvent = [];
  List<latapeAction.Action> _selectedAction = [];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColor = 0;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _selectedEvent = widget.task!.events!;
      _selectedAction = widget.task!.actions!;
      _selectedRepeat = widget.task!.repeat!;
    }

    DeviceInfo deviceInfo = DeviceInfo();
    deviceInfo.getDeviceName().then((value) {
      setState(() {
        deviceName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleBar(),
              _inputField(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: Get.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      backgroundColor: context.theme.colorScheme.background,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        // ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  _titleBar() {
    return Text(widget.task == null ? "Add Rule" : "Update Rule",
        style: headingStyle);
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 4)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 8)),
    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      Get.snackbar(
        "Error Occured!",
        "Date is not selected",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickTime = await _showTimePicker();

    if (pickTime != null) {
      // ignore: use_build_context_synchronously
      String formatedTime = pickTime.format(context);

      setState(() {
        if (isStartTime) {
          _startTime = formatedTime;
        } else {
          _endTime = formatedTime;
        }
      });
    } else {
      Get.snackbar(
        "Error Occured!",
        "Time is not selected",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _bottomSheetButton(
      {required String label,
      required BuildContext context,
      required Color color,
      required Function()? onTap,
      IconData? icon,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 7),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,

        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[700]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : color,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: isClose
                        ? Get.isDarkMode
                            ? Colors.white
                            : Colors.black
                        : Colors.white,
                    size: 30,
                  )
                : const SizedBox(),
            Text(
              label,
              style: titleStyle.copyWith(
                fontSize: 18,
                color: isClose
                    ? Get.isDarkMode
                        ? Colors.white
                        : Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showEventList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), 
      shrinkWrap: true,
      itemCount: eventController.eventList.length,
      itemBuilder: (_, index) {
        final event = eventController.eventList[index];
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
                          child: EventTile(
                            event,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    ); 
  }

  Widget _showActionList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), 
      shrinkWrap: true,
      itemCount: actionController.actionList.length,
      itemBuilder: (_, index) {
        final action = actionController.actionList[index];
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
                          child: ActionTile(
                            action,
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

  _inputField() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Obx(() {
            return _showEventList();
          }),
          ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200), // 设置按钮的最大宽度
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed:() async {
              await Get.to(() => const AddEventPage());
              _taskController.getTasks();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 3),
                Text('Add a new Event'),
              ],
            ),
          ),
        ),
        
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200), // 设置按钮的最大宽度
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: null,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 3),
                Text('Add a new Condition'),
              ],
            ),
          ),
        ),
        Obx(() {
          return _showActionList();
        }),
        
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200), // 设置按钮的最大宽度
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed:() async {
              await Get.to(() => const AddActionPage());
              _taskController.getTasks();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 3),
                Text('Add a new Action'),
              ],
            ),
          ),
        ),

          MyInputField(
            title: "Repeat",
            hint: _selectedRepeat,
            widget: DropdownButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              iconSize: 32,
              elevation: 4,
              padding: const EdgeInsets.only(right: 5),
              style: subTitleStyle,
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRepeat = newValue!;
                });
              },
              items: repeatList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: subTitleStyle,
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _colorPallet(),
              MyButton(
                label: widget.task == null ? "Create Rule" : "Update Rule",
                onTap: () => _validateData(),
              ),
            ],
          )

        ],
      ),
    );
  }

  _validateData() {
    if (eventController.eventList.isNotEmpty && actionController.actionList.isNotEmpty) {
      // Add to database
      _saveTask();
      Get.back();
    } else {
      Get.snackbar(
        "Required",
        "event and action field is required!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.grey,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 35,
        ),
        colorText: Colors.red,
      );
    }
  }

  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        Wrap(
          children: List<Widget>.generate(4, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryColor
                      : index == 1
                          ? pinkColor
                          : index == 2
                              ? yellowishColor
                              : greenColor,
                  child: Icon(
                    _selectedColor == index ? Icons.done : null,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

    void _saveTask() {
    if (widget.task == null) {
      _taskController.addTask(Task(
        id: DateTime.now().millisecondsSinceEpoch,
        events: eventController.eventList,
        actions: actionController.actionList,
        repeat: _selectedRepeat,
      ));
    } else {
      _taskController.addTask(Task(
        id: widget.task!.id,
        events: eventController.eventList,
        actions: actionController.actionList,
        repeat: _selectedRepeat,
      ));
    }
    
    Get.back();
  }

  
}
