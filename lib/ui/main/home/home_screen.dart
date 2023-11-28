import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/ui/main/home/home_page.dart';
import 'package:student_management/ui/main/home/profile_page.dart';
import 'package:student_management/ui/main/home/rank_page.dart';
import 'package:student_management/utils/colors.dart';

import '../../../model/local_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthRepository _authRepository = AuthRepository();
  int currentPageIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const RankPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser?>(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: AppColors.infoMain,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.view_column),
              icon: Icon(Icons.view_column_outlined),
              label: "Rank"),
          NavigationDestination(
              selectedIcon: Icon(Icons.person),
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