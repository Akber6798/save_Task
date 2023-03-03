import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_task/screens/auth_provider.dart';
import 'package:save_task/utilities/appvalues.dart';
import 'package:save_task/utilities/refactor_widgets/button.dart';

class LoginwithNumberScreen extends StatefulWidget {
  const LoginwithNumberScreen({super.key});

  @override
  State<LoginwithNumberScreen> createState() => _LoginwithNumberScreenState();
}

final phoneNumerController = TextEditingController();

class _LoginwithNumberScreenState extends State<LoginwithNumberScreen> {
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
                  'Your Phonenumber',
                  style: TextStyle(color: AppValues.textColor),
                ),
              ),
              SizedBox(height: 5.h),
              TextFormField(
                cursorColor: AppValues.textColor,
                style: TextStyle(color: AppValues.textColor),
                keyboardType: TextInputType.phone,
                controller: phoneNumerController,
                decoration: InputDecoration(
                  hintText: '+91 97 3456 789',
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
                  title: 'Login',
                  pressed: () {
                    context.read<AuthenticationService>().loginWithPhoneNumber(
                        context, phoneNumerController.text);
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneNumerController.dispose();
    super.dispose();
  }
}
