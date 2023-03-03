import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_task/screens/auth_provider.dart';
import 'package:save_task/screens/bottom_controller.dart';
import 'package:save_task/utilities/appvalues.dart';
import 'package:save_task/utilities/refactor_widgets/button.dart';
import 'package:save_task/utilities/util.dart';

class VarifyCodeScreen extends StatefulWidget {
  String varificationId;
  VarifyCodeScreen({super.key, required this.varificationId});

  @override
  State<VarifyCodeScreen> createState() => _VarifyCodeScreenState();
}

final phoneNumerVerifyController = TextEditingController();

class _VarifyCodeScreenState extends State<VarifyCodeScreen> {
  final auth = FirebaseAuth.instance;
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
                controller: phoneNumerVerifyController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.message, color: AppValues.textColor),
                  hintText: '6 digit code',
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
                  title: 'Verify',
                  pressed: () async {
                    final credential = PhoneAuthProvider.credential(
                        verificationId: widget.varificationId,
                        smsCode: phoneNumerVerifyController.text.toString());
                    try {
                      await auth.signInWithCredential(credential);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  BottomScreenController())));
                    } on FirebaseAuthException catch (error) {
                      Util().showToast(error.message.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    phoneNumerVerifyController.dispose();
    super.dispose();
  }
}
