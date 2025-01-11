import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'm_textfield.dart';

class mDialog extends StatelessWidget {
  final BuildContext context;
  final Size size;
  final Map<String,Map<bool,TextEditingController>> hints;
  final VoidCallback? onPressed;
  const mDialog({super.key,required this.context, required this.size, required this.hints, this.onPressed});

  @override
  Widget build(BuildContext _) {
    return Dialog(

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0.r)
      ),
      child: Container(
        constraints: BoxConstraints(
            maxWidth: size.width,
            maxHeight: size.height
        ),
        padding: EdgeInsets.symmetric(vertical: 10.r,horizontal: 20.r),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                  ),
                  child: Icon(Icons.close,size: 16.r,),
                ),
              ),
            ),
            Gap(20.r),
            Column(
              children: hints.entries.map((e) => Column(
                children: [
                  mTextField(label: e.key, controller: e.value.entries.first.value,enabled: e.value.entries.first.key,),
                  Gap(8.r)
                ],
              ),).toList(),

            ),

            Gap(10.0.r),
            FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                    )
                ),
                onPressed: onPressed,
                child: Text('Save',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white
                  ),)
            )
          ],
        ),
      ),
    );
  }
}
