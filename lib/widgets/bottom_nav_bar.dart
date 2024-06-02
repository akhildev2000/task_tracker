import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:vaanam_task/services/main_screen_provider.dart';
import 'bottom_nav.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifer, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNav(
                  icon: mainScreenNotifer.pageIndex == 0
                      ? Ionicons.home
                      : Ionicons.home_outline,
                  onTap: () {
                    mainScreenNotifer.pageIndex = 0;
                  },
                ),
                BottomNav(
                  icon: mainScreenNotifer.pageIndex == 1
                      ? Ionicons.search
                      : Ionicons.search,
                  onTap: () {
                    mainScreenNotifer.pageIndex = 1;
                  },
                ),
                BottomNav(
                  onTap: () {
                    mainScreenNotifer.pageIndex = 2;
                  },
                  icon: mainScreenNotifer.pageIndex == 2
                      ? Ionicons.person
                      : Ionicons.person_outline,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
