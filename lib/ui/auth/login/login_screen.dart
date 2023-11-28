import 'package:flutter/material.dart';
import 'package:student_management/repository/auth_repository.dart';
import 'package:student_management/ui/auth/auth_header.dart';
import 'package:student_management/ui/component/loading.dart';
import 'package:student_management/ui/component/text/small_text.dart';
import '../../../utils/colors.dart';
import '../../component/button/sm_elevated_button.dart';
import '../../component/text/medium_text.dart';
import '../../component/text_field/sm_auth_text_field.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {

  final Function() toggleView;

  const LoginScreen({super.key, required this.toggleView});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            const AuthHeader(desc: "Login now to get protected."),
            SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        SmAuthTextField(
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                            placeholder: "Email",
                            hint: "email@example.com"),
                        const SizedBox(height: 24),
                        SmAuthTextField(
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            isPasswordField: true,
                            placeholder: "Password",
                            hint: "*********"),
                        const SizedBox(height: 16),
                      ])),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MediumText(
                      text: "Forgot password",
                      color: AppColors.neutral90,
                      fontWeight: FontWeight.w600,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SmElevatedButton(text: "Login", onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      print(email);
                      print(password);
                      dynamic result = await _authRepository.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = "Could not sign in with those credentials";
                        });
                        }
                      } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill input")));
                    }
                  },),
                  if(error.isNotEmpty) ... [
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        SmallText(text: error, color: AppColors.dangerMain, textAlign: TextAlign.center)
                      ],
                    )
                  ] else ... [
                    const SizedBox(height: 0)
                  ],
                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MediumText(
                              text: "Don't have an account?",
                              color: AppColors.neutral70,
                              fontWeight: FontWeight.w400),
                          MediumText(
                              text: "Register",
                              color: AppColors.neutral90,
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
