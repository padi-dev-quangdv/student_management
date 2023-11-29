import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/local_user.dart';
import 'package:student_management/ui/auth/authenticate.dart';
import 'package:student_management/ui/main/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<LocalUser?>(context);

    if(user == null) {
      return const Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
