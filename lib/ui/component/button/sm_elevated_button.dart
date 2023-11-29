import 'package:flutter/material.dart';

class SmElevatedButton extends StatelessWidget {

  final String text;
  Color backgroundColor;
  bool isLargeButton;
  final Function()? onPressed;

  SmElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = const Color(0xFF3676F7), // default is main color
      this.isLargeButton = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: isLargeButton ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Expanded(
          flex: isLargeButton ? 1 : 0,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'PlusJakartaSans'
                )),
              )
          ),
        ),
      ],
    );
  }
}
