import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_task/screens/auth_provider.dart';
import 'package:save_task/utilities/appvalues.dart';
import 'package:save_task/utilities/refactor_widgets/button.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 70.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Email',
                  style: TextStyle(color: AppValues.textColor),
                ),
              ),
              SizedBox(height: 5.h),
              TextFormField(
                cursorColor: AppValues.textColor,
                style: TextStyle(color: AppValues.textColor),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Please enter your email';
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'abcd@gmail.com',
                  hintStyle: TextStyle(color: AppValues.textColor),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppValues.barColor,
                ),
              ),
              SizedBox(height: 50.h),
              Button(
                  loading: context.watch<AuthenticationService>().isLoading,
                  title: 'Reset',
                  pressed: () {
                    context.read<AuthenticationService>().forgottPassword(
                        context, emailController.text.toString());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
