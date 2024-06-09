import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latape_app/models/event.dart';
import 'package:latape_app/theme/theme.dart';
import 'package:latape_app/utils/util.dart';

class EventTile extends StatelessWidget {
  final Event? event;
  const EventTile(this.event, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(Random().nextInt(5)),
        ),
        child: Row(
          children: [
            // 添加图标
            Icon(
              Icons.event, // 使用预定义的图标
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 16), // 添加间距
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${event?.eventType}${buildEventFilters(event)}",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  // 添加其他内容
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishColor;
      case 1:
        return pinkColor;
      case 2:
        return yellowishColor;
      case 3:
        return darkGreyColor;
      case 4:
        return greenColor;
      default:
        return lightBluishColor;
    }
  }


  


}
