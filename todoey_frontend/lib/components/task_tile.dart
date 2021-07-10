import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longTapFunction;
  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.longTapFunction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onLongPress: longTapFunction,
        title: Text(
          taskTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkboxCallback,
        ));
  }
}
