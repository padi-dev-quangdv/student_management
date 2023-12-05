import 'package:flutter/material.dart';
import 'package:student_management/ui/component/text/medium_text.dart';
import 'package:student_management/utils/colors.dart';

class SmAuthPasswordTextField extends StatefulWidget {
  final String placeholder;
  final String hint;
  final String? Function(String?)? validator;
  final Function (String)? onChanged;


  const SmAuthPasswordTextField({super.key,
    required this.placeholder,
    required this.hint,
    required this.validator,
    required this.onChanged});

  @override
  State<SmAuthPasswordTextField> createState() => _SmAuthPasswordTextFieldState();
}

class _SmAuthPasswordTextFieldState extends State<SmAuthPasswordTextField> {

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {

    var icon = isShowPassword ? Icons.visibility : Icons.visibility_off;
    Widget iconShowPassword = GestureDetector(
        onTap: () {
         setState(() {
           isShowPassword = !isShowPassword;
         });
        }, child: Icon(icon, color: Colors.grey[500],));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediumText(text: widget.placeholder),
        const SizedBox(height: 10),
        TextFormField(
          onChanged: widget.onChanged,
          validator: widget.validator,
          obscureText: isShowPassword,
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
              hintText: widget.hint,
              hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: "PlusJarkataSans",
              fontWeight: FontWeight.w500,
              color: AppColors.neutral70
            ),
            suffixIcon: iconShowPassword
          ),
        )
      ],
    );
  }
}
