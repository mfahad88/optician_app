import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class mSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const mSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      padding: WidgetStatePropertyAll(EdgeInsets.only(left: 10.r)),
      leading: Icon(Icons.search),
      elevation: WidgetStatePropertyAll(1.0),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
      )
      ),
      onChanged: onChanged,
    );
  }
}
