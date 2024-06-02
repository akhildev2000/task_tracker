import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaanam_task/pages/profile_page.dart';
import 'package:vaanam_task/pages/search.dart';
import 'package:vaanam_task/widgets/bottom_nav_bar.dart';

import '../services/main_screen_provider.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.user});
  final String user;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> pageList;

  @override
  void initState() {
    super.initState();
    pageList = [
      HomePage(
        user: widget.user,
      ),
      Search(
        user: widget.user,
      ),
      ProfilePage(
        user: widget.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifer, child) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.867),
          body: pageList[mainScreenNotifer.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
