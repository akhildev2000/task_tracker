import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaanam_task/models/task.dart';
import 'package:vaanam_task/pages/task_details.dart';
import 'package:vaanam_task/services/main_model_provider.dart';
import 'package:vaanam_task/widgets/org_card.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<MainModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xff2a2e3d),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SearchBar(
                  backgroundColor: WidgetStateColor.transparent,
                  shadowColor: WidgetStateColor.transparent,
                  hintText: 'Search',
                  textStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  onChanged: (query) {
                    taskProvider.searchTasks(query);
                  },
                ),
              ),
            ),
            Expanded(
              child: Consumer<MainModel>(
                builder: (context, taskProvider, child) {
                  List<Task> tasks = taskProvider.tasks;
                  return ListView.builder(
                    itemCount: taskProvider.tasks.length,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
