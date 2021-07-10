import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tasks_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String taskText;
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: Column(
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),
              ),
              TextField(
                onChanged: (value) {
                  taskText = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                color: Colors.lightBlueAccent,
                minWidth: double.infinity,
                height: 48,
                onPressed: () {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(taskText);
                  Navigator.pop(context);
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
