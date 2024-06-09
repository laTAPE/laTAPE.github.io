import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:latape_app/controllers/action.controller.dart';
import 'package:latape_app/models/action.dart' as latapeAction;
import 'package:latape_app/theme/theme.dart';
import 'package:latape_app/ui/widgets/button.dart';
import 'package:latape_app/ui/widgets/input_field.dart';



class AddActionPage extends StatefulWidget {
  final latapeAction.Action? action;

  const AddActionPage({Key? key, this.action}) : super(key: key);

  @override
  State<AddActionPage> createState() => _AddActionPageState();
}

class _AddActionPageState extends State<AddActionPage> {
  
  final ActionController actionController = Get.find();


  String _selectedActionType = "None";
  String _selectedLocation = "None";
  String _selectedTime = "None";
  String _selectedObject = "None";
  List<String> actionTypeList = ["Light_Turn_On", "Light_Turn_Off", "AC_Turn_On", "AC_Turn_Off","Speak_VoiceMessage","Heater_Turn_On"];
  List<String> locationList = ["CurrentLocation", "Home", "Building", "Office"];
  String time = "None"; // start time  end time
  List<String> objectList = ["light01", "light02", "light03", "light04"];
  @override
  void initState() {
    super.initState();

    if (widget.action != null) {
      _selectedActionType = widget.action!.actionType!;
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
    return Text(widget.action == null ? "Add Action" : "Update Action",
        style: headingStyle);
  }

  _inputField() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          MyInputField(
            title: "actionType",
            hint: _selectedActionType,
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
                  _selectedActionType = newValue!;
                });
              },
              items: actionTypeList.map<DropdownMenuItem<String>>((String value) {
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
                label: widget.action == null ? "Create Action" : "Update Action",
                onTap: () => _validateData(),
              ),
            ],
          )

        ],
      ),
    );
  }

  void _validateData() {
    if (_selectedActionType == "None") {
      Get.snackbar(
        "Required",
        "actionType is required!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.warning, color: Colors.white),
      );
    } else {
      _saveAction();
    }
  }

  void _saveAction() {
    if (widget.action == null) {
      actionController.addAction(latapeAction.Action(
        id: DateTime.now().millisecondsSinceEpoch,
        actionType: _selectedActionType,
        locationFilter: _selectedLocation,
        timeFilter: _selectedTime,
        objectFilter: _selectedObject,
      ));
    } else {
      actionController.updateAction(latapeAction.Action(
        id: widget.action!.id,
        actionType: _selectedActionType,
        locationFilter: _selectedLocation,
        timeFilter: _selectedTime,
        objectFilter: _selectedObject,
      ));
    }
    Get.back();
  }

}
