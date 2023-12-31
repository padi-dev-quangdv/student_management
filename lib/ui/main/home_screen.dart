import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/ui/main/challenge/challenge_page.dart';
import 'package:student_management/ui/main/home/home_page.dart';
import 'package:student_management/ui/main/profile/profile_page.dart';
import 'package:student_management/ui/main/rank/rank_page.dart';
import 'package:student_management/utils/colors.dart';

import '../../model/local_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const ChallengePage(),
    const RankPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: null,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.home_outlined, color: AppColors.infoMain),
              icon: Icon(Icons.home_outlined),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.local_fire_department_outlined, color: AppColors.infoMain),
              icon: Icon(Icons.local_fire_department_outlined),
              label: "Challenge"),
          NavigationDestination(
              selectedIcon: Icon(Icons.view_column_outlined, color: AppColors.infoMain),
              icon: Icon(Icons.view_column_outlined),
              label: "Rank"),
          NavigationDestination(
              selectedIcon: Icon(Icons.person_outline, color: AppColors.infoMain),
              icon: Icon(Icons.person_outline),
              label: "Profile"),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
    );
  }
}