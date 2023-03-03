import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_task/screens/bottom_controller.dart';
import 'package:save_task/screens/login_screen/login_screen.dart';
import 'package:save_task/utilities/appvalues.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});
  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
FirebaseAuth auth = FirebaseAuth.instance;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isLoggedInOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              color: AppValues.textColor,
              height: 200,
              width: 200,
              image: const AssetImage('assets/notes.png')),
          SizedBox(height: 30.h),
          Text(
            'Save Task',
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w500,
                color: AppValues.textColor),
          )
        ],
      ),
    ));
  }
   isLoggedInOrNot() {
    if (auth.currentUser == null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => const LoginScreen())));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => BottomScreenController())));
      });
    }
  }
}
