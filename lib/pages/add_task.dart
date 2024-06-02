import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaanam_task/services/user_provider.dart';
import 'package:vaanam_task/widgets/widget.dart';
import '../models/task.dart';
import '../services/db_services.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

final _titleController = TextEditingController();
final _descriptionController = TextEditingController();
var _employeeId = '';
final _formKey = GlobalKey<FormState>();

class _AddTaskState extends State<AddTask> {
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
          ])),
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
                      const Text(
                        "Create",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "New task",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Widgets().label("Task Title"),
                              const SizedBox(
                                height: 12,
                              ),
                              Widgets().title(
                                  context: context,
                                  titleController: _titleController),
                              const SizedBox(
                                height: 10,
                              ),
                              Widgets().label("Assign to"),
                              const SizedBox(
                                height: 12,
                              ),
                              Consumer<UserProvider>(
                                  builder: (context, userProvider, child) {
                                return Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2a2e3d),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                        hintText: "Employee",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20, bottom: 5)),
                                    items:
                                        userProvider.usernames.map((username) {
                                      return DropdownMenuItem<String>(
                                        value: username,
                                        child: Text(
                                          username,
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (selectedUsername) {
                                      setState(() {
                                        _employeeId =
                                            selectedUsername.toString();
                                      });
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              Widgets().label("Description"),
                              const SizedBox(
                                height: 12,
                              ),
                              Widgets().description(
                                  context: context,
                                  descriptionController:
                                      _descriptionController),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Widgets().createButton(
                        text: 'Add Task',
                        context: context,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final task = Task(
                              comments: '',
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              title: _titleController.text,
                              description: _descriptionController.text,
                              employeeId: _employeeId,
                              isComplete: false,
                            );
                            await DbService().addTask(task);
                            // print('Task added');
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                      )
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
