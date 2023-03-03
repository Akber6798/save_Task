import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_task/utilities/appvalues.dart';

class Button extends StatelessWidget {
  final String title;
  VoidCallback pressed;
  final bool loading;
  Button(
      {super.key,
      required this.title,
      required this.pressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 180.w,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppValues.barColor),
          onPressed: pressed,
          child: loading
              ? CircularProgressIndicator(
                  color: AppValues.textColor,
                )
              : Text(
                  title,
                  style: TextStyle(fontSize: 20.sp, color: AppValues.textColor),
                )),
    );
  }
}
