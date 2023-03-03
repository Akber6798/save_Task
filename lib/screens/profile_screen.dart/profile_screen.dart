import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_task/screens/auth_provider.dart';
import 'package:save_task/screens/bottom_controller.dart';
import 'package:save_task/utilities/appvalues.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: ()async{
         Navigator.push(context, MaterialPageRoute(builder: ((context) => BottomScreenController())));
        return Future.value(false);
       },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 100.h),
                CircleAvatar(
                    radius: 60,
                    backgroundColor: AppValues.barColor,
                    backgroundImage: checkingimage()),
                SizedBox(height: 20.h),
                Text(
                  checkinName(),
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: AppValues.textColor),
                ),
                SizedBox(height: 10.h),
                Text(auth.currentUser!.email.toString(),
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w300,
                        color: AppValues.textColor)),
                SizedBox(height: 260.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Log out',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: AppValues.textColor),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<AuthenticationService>().logOut(context);
                        },
                        icon: Icon(
                          Icons.login_sharp,
                          size: 25,
                          color: AppValues.textColor,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkingimage() {
    if (auth.currentUser!.photoURL == null) {
      return const AssetImage('assets/profile.png');
    } else {
      return NetworkImage(auth.currentUser!.photoURL.toString());
    }
  }

  checkinName() {
    if (auth.currentUser!.displayName == null) {
      return 'No name';
    } else {
      return auth.currentUser!.displayName.toString();
    }
  }
}
