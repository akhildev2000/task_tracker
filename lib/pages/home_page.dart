import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:vaanam_task/pages/add_task.dart';
import 'package:vaanam_task/pages/task_details.dart';
import 'package:vaanam_task/services/main_model_provider.dart';
import 'package:vaanam_task/widgets/org_card.dart';
import '../models/task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    final mainModelProvider = Provider.of<MainModel>(context);
    mainModelProvider.loadTasks();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Task Tracker",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black87,
        actions: [
          user == "manager"
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTask(),
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 39,
                    decoration: BoxDecoration(
                      color: const Color(0xff2a2e3d),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Ionicons.add_circle_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Add Task",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: Consumer<MainModel>(
        builder: (context, taskProvider, child) {
          List<Task> tasks = taskProvider.tasks;
          return tasks.isNotEmpty
              ? ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsScreen(
                                task: tasks[index],
                                user: user,
                              ),
                            ));
                      },
                      child: OrgCard(
                        title: tasks[index].title,
                        iconData: Icons.compass_calibration_rounded,
                        iconColor: Colors.black87,
                        time: tasks[index].employeeId,
                        check: tasks[index].isComplete,
                        iconBgColor: Colors.white,
                      ),
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 35, top: 35),
                  child: Image.asset('assets/Pose23.png'),
                );
        },
      ),
    );
  }
}
