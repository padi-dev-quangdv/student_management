import 'package:flutter/material.dart';
import 'package:student_management/ui/component/switch/sm_switch.dart';
import 'package:student_management/ui/component/text/large_text.dart';
import 'package:student_management/utils/colors.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool nightModeValue = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.nights_stay_rounded, color: AppColors.infoFocus),
                const SizedBox(width: 16),
                Expanded(child: Column(
                  children: [
                    Row(
                      children: [
                        LargeText(text: "Night mode"),
                        const Expanded(child: SizedBox()),
                        SmSwitch(onChanged: (bool value) {
                          setState(() {
                            nightModeValue = !nightModeValue;
                          });
                        }, value: nightModeValue)
                      ],
                    ),
                    const Divider()
                  ],
                ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.language, color: AppColors.infoFocus),
                const SizedBox(width: 16),
                Expanded(child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        LargeText(text: "Language: "),
                        const Expanded(child: SizedBox()),
                        LargeText(text: "ENGLISH", color: AppColors.infoMain)
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider()
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
