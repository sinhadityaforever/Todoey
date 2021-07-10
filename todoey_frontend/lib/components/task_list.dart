import 'package:flutter/material.dart';
import 'package:todo/components/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tasks_data.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkBoxState) {
                taskData.updateTask(task);
              },
              longTapFunction: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}

// (bool checkBoxState) {
//           setState(() {
//             isChecked = checkBoxState;
//           });
//         },
