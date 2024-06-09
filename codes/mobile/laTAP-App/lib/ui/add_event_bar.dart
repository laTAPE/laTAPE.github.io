import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latape_app/controllers/event.controller.dart';
import 'package:latape_app/models/event.dart';
import 'package:latape_app/theme/theme.dart';
import 'package:latape_app/ui/widgets/button.dart';
import 'package:latape_app/ui/widgets/input_field.dart';



class AddEventPage extends StatefulWidget {
  final Event? event;

  const AddEventPage({Key? key, this.event}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  
  final EventController eventController = Get.find();


  String _selectedEventType = "None";
  String _selectedLocation = "None";
  String _selectedTime = "None";
  String _selectedObject = "None";
  List<String> eventTypeList = ["Person_Entry", "Person_Leave", "Light_On", "Light_Off","AC_On","AC_Off"];
  List<String> locationList = ["CurrentLocation", "Home", "Building", "Office"];
  String time = "None"; // start time  end time
  List<String> objectList = ["light01", "light02", "light03", "light04"];
  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      _selectedEventType = widget.event!.eventType!;
      // _selectedRepeat = widget.event!.repeat!;
    }
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
    return Text(widget.event == null ? "Add Event" : "Update Event",
        style: headingStyle);
  }

  _inputField() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          MyInputField(
            title: "eventType",
            hint: _selectedEventType,
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
                  _selectedEventType = newValue!;
                });
              },
              items: eventTypeList.map<DropdownMenuItem<String>>((String value) {
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

          MyInputField(
            title: "location",
            hint: _selectedLocation,
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
                  _selectedLocation = newValue!;
                });
              },
              items: locationList.map<DropdownMenuItem<String>>((String value) {
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


          MyInputField(
            title: "object",
            hint: _selectedObject,
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
                  _selectedObject = newValue!;
                });
              },
              items: objectList.map<DropdownMenuItem<String>>((String value) {
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
              // _colorPallet(),
              MyButton(
                label: widget.event == null ? "Create Event" : "Update Event",
                onTap: () => _validateData(),
              ),
            ],
          )

        ],
      ),
    );
  }

  void _validateData() {
    if (_selectedEventType == "None") {
      Get.snackbar(
        "Required",
        "eventType is required!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
      );
    } else {
      _saveEvent();
    }
  }

  void _saveEvent() {
    if (widget.event == null) {
      eventController.addEvent(Event(
        id: DateTime.now().millisecondsSinceEpoch,
        eventType: _selectedEventType,
        locationFilter: _selectedLocation,
        timeFilter: _selectedTime,
        objectFilter: _selectedObject,
      ));
    } else {
      eventController.updateEvent(Event(
        id: widget.event!.id,
        eventType: _selectedEventType,
        locationFilter: _selectedLocation,
        timeFilter: _selectedTime,
        objectFilter: _selectedObject,
      ));
    }
    Get.back();
  }

}
