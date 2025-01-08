import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class mTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool? enabled;
  const mTextField({super.key, required this.label, required this.controller, this.enabled});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.end,
        ),
        Gap(10),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,

          ),
        )
      ],
    );
  }
}
