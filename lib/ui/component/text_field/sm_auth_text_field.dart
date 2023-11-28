import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/utils/colors.dart';

class SmAuthTextField extends StatelessWidget {
  final String placeholder;
  final String hint;
  final String? Function(String?)? validator;
  final Function (String)? onChanged;
  bool isPasswordField;


  SmAuthTextField({super.key,
    required this.placeholder,
    required this.hint,
    required this.validator,
    required this.onChanged,
    this.isPasswordField = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediumText(text: placeholder),
        const SizedBox(height: 10),
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          obscureText: isPasswordField,
          obscuringCharacter: "*",
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.infoMain),
                  borderRadius: BorderRadius.circular(7)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.infoMain),
                  borderRadius: BorderRadius.circular(7)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.dangerMain),
                  borderRadius: BorderRadius.circular(7)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.dangerMain),
                  borderRadius: BorderRadius.circular(7)),
              hintText: hint,
              hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: "PlusJarkataSans",
              fontWeight: FontWeight.w500,
              color: AppColors.neutral70
            )
          ),
        )
      ],
    );
  }
}
