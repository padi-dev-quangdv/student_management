import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/local_user.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/repository/database_repository.dart';
import 'package:student_management/ui/main/profile/profile_field.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/utils/colors.dart';

import '../settings/settings_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {

    final AuthRepository authRepository = AuthRepository();
    final user = Provider.of<LocalUser>(context);
    final DatabaseRepository databaseRepository = DatabaseRepository();

    Future pickImageFromGallery(Student student) async {
      final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        _selectedImage = File(returnedImage!.path);
      });
      databaseRepository.uploadImageToFirebase(_selectedImage!, student);
    }

    return StreamBuilder(
        stream: DatabaseRepository(uid: user.uid).student,
        builder: (context, snapshot) {
          Student student = snapshot.hasData
              ? snapshot.data ?? Student.defaultStudent()
              : Student.defaultStudent();

          return Scaffold(
            appBar: AppBar(
              title: LargeText(text: "Profile",size: 20, fontWeight: FontWeight.w700),
              actions: [
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(context: context, builder: (BuildContext context) {
                        return SettingsScreen();
                      });
                    },
                    child: const Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Icon(Icons.settings)
                    )
                )
              ],
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImageFromGallery(student);
                        },
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(50),
                            child: student.profileImageUrl.isEmpty
                                ? _selectedImage == null
                                    ? const Icon(Icons.person, size: 80, color: AppColors.infoMain)
                                    : Image.asset(_selectedImage!.path, fit: BoxFit.cover)
                                : FadeInImage.assetNetwork(image: student.profileImageUrl,
                                    placeholder: "assets/image/img_loading.png",
                                    fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      LargeText(text: student.email),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () {
                            authRepository.signOut();
                          },
                          child: const Text("Sign out"),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MediumText(text: "Information", fontWeight: FontWeight.w700, color: AppColors.neutral90),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: AppColors.absWhite,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Column(
                          children: [
                            ProfileField(
                                title: "Name",
                                content: student.fullName,
                                onTap: () {
                                  //todo: navigate to detail screen
                                }),
                            ProfileField(
                                title: "Class",
                                content: student.className,
                                onTap: () {
                                  //todo: navigate to detail screen
                                }),
                          ],
                        ),
                      ),
                    ]
                  ),
                  Column(
                    children: [
                      MediumText(text: "Scores", fontWeight: FontWeight.w700, color: AppColors.neutral90),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: AppColors.absWhite,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Column(
                          children: [
                            ProfileField(
                                title: "Android",
                                content: student.android.toString()
                            ),
                            ProfileField(
                                title: "Flutter",
                                content: student.flutter.toString()
                            ),
                            ProfileField(
                                title: "Swift",
                                content: student.swift.toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
