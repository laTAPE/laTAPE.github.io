
import 'package:flutter/material.dart';
import 'package:latape_app/theme/theme.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MyMultiSelect extends StatelessWidget {
  final String title;
  final String hint;
  final MultiSelectController<String>? controller;
  final Widget? widget;

  const MyMultiSelect({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: MultiSelectDropDown<String>(
                      controller: controller,
                      // borderColor: Colors.black,
                      borderWidth: 1,
                      focusedBorderWidth: 1,
                      // clearIcon: const Icon(Icons.reddit),
                      onOptionSelected: (options) {},
                      options: const <ValueItem<String>>[
                        ValueItem(label: 'Option 1', value: 'User 1'),
                        ValueItem(label: 'Option 2', value: 'User 2'),
                        ValueItem(label: 'Option 3', value: 'User 3'),
                        ValueItem(label: 'Option 4', value: 'User 4'),
                        ValueItem(label: 'Option 5', value: 'User 5'),
                      ],
                      maxItems: 4,
                      singleSelectItemStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      chipConfig: const ChipConfig(
                          wrapType: WrapType.wrap, backgroundColor: Colors.green),
                      optionTextStyle: const TextStyle(fontSize: 16),
                      selectedOptionIcon: const Icon(
                        Icons.check_circle,
                        color: Colors.pink,
                      ),
                      selectedOptionBackgroundColor: Colors.grey.shade300,
                      selectedOptionTextColor: Colors.blue,
                      dropdownMargin: 2,
                      onOptionRemoved: (index, option) {},
                      optionBuilder: (context, valueItem, isSelected) {
                        return ListTile(
                          title: Text(valueItem.label),
                          subtitle: Text(valueItem.value.toString()),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle)
                              : const Icon(Icons.radio_button_unchecked),
                        );
                      },
                    ),
        ),
      ],
    );
    
  }

  
}