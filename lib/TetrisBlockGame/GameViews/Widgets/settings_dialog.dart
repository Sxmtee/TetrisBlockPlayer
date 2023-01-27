import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Colors.brown.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Settings",
            style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.yellow.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          content: Table(
            columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1)},
            children: [
              TableRow(children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "Sound",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeTrackColor: Colors.yellow.shade600,
                    activeColor: Colors.yellow.shade900,
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "Music",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeTrackColor: Colors.yellow.shade600,
                    activeColor: Colors.yellow.shade900,
                  ),
                ),
              ]),
            ],
          ),
          actions: [
            MaterialButton(
              child: Text(
                "OK",
                style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.yellow.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ));
  }
}
