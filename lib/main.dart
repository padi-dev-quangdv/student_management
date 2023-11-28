import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/local_user.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/ui/wrapper.dart';
import 'package:student_management/utils/colors.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LocalUser?>.value(
      initialData: null,
      value: AuthRepository().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.infoMain),
          useMaterial3: true,
        ),
        home: const Wrapper()
      ),
    );
  }
}

