// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaanam_task/widgets/widget.dart';
import '../models/task.dart';
import '../services/db_services.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task, required this.user});
  final Task task;
  final String user;
  @override
  TaskDetailsScreenState createState() => TaskDetailsScreenState();
}

class TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff1d1e26),
              Color(0xff252041),
            ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Widgets().label('Title'),
                      const SizedBox(height: 12),
                      Widgets().taskDetails(
                          text: widget.task.title, context: context),
                      const SizedBox(height: 10),
                      Widgets().label('Employee ID'),
                      const SizedBox(height: 12),
                      Widgets().taskDetails(
                          text: widget.task.employeeId, context: context),
                      const SizedBox(height: 10),
                      Widgets().label('Task Description'),
                      const SizedBox(height: 12),
                      Widgets().taskDetails(
                          text: widget.task.description, context: context),
                      const SizedBox(height: 10),
                      Widgets().label('Earlier comments'),
                      const SizedBox(height: 12),
                      Widgets().commentBox(
                          employee: widget.task.employeeId,
                          comment: widget.task.comments,
                          context: context),
                      const SizedBox(height: 10),
                      widget.user == 'manager'
                          ? const SizedBox()
                          : Widgets().label('Add a comment'),
                      const SizedBox(height: 12),
                      widget.user == 'manager'
                          ? const SizedBox()
                          : Widgets().description(
                              descriptionController: _commentController,
                              context: context),
                      const SizedBox(height: 12),
                      CheckboxListTile(
                          title: Widgets().label('Complete'),
                          value: widget.task.isComplete,
                          onChanged: (value) async {
                            // Mark task as complete
                            final task = widget.task;
                            task.isComplete = value ?? false;
                            await DbService().updateTask(task);
                            Navigator.pop(context);
                          }),
                      widget.user == "manager"
                          ? Widgets().createButton(
                              text: "Delete Task",
                              onTap: () async {
                                final task = widget.task;
                                task.comments = _commentController.text;
                                await DbService().deleteTask(task);
                                Navigator.pop(context);
                              },
                              context: context)
                          : widget.task.isComplete
                              ? const SizedBox()
                              : Widgets().createButton(
                                  text: "Add Comment",
                                  onTap: () async {
                                    final task = widget.task;
                                    task.comments = _commentController.text;
                                    await DbService().updateTask(task);
                                    Navigator.pop(context);
                                  },
                                  context: context)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
