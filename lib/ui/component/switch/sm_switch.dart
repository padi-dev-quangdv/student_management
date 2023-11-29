import 'package:flutter/material.dart';
import 'package:student_management/utils/colors.dart';

class SmSwitch extends StatelessWidget {

  final Function(bool)? onChanged;
  final bool value;

  const SmSwitch({super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: value,
        activeColor: AppColors.infoMain,
        onChanged: onChanged
    );
  }
}
