import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class mTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const mTextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Gap(10),
        Container(
          constraints: BoxConstraints(
            maxWidth: 200
          ),
          child: TextField(
            controller: controller,
          ),
        )
      ],
    );
  }
}
