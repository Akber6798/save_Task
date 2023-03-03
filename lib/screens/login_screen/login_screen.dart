import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_task/screens/auth_provider.dart';
import 'package:save_task/screens/login_screen/forgot_screen.dart';
import 'package:save_task/screens/login_screen/login_with_number_screen.dart';
import 'package:save_task/screens/signup_screen/signup_screen.dart';
import 'package:save_task/utilities/appvalues.dart';
import 'package:save_task/utilities/refactor_widgets/button.dart';
import 'package:save_task/utilities/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
ValueNotifier<bool> obsecurePassword = ValueNotifier(true);
FocusNode emailFocusNote = FocusNode();
FocusNode passwordFocusNote = FocusNode();
FirebaseAuth auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Do you want to exit an App'),
                actions: [
                  TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No')),
                ],
              );
            }));

        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login to Account',
                      style: TextStyle(
                          fontSize: 25.sp, color: AppValues.textColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Continue by login to your account',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: AppValues.textColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: 50.h),
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
                    onFieldSubmitted: ((value) {
                      Util.fieldFocusChange(
                          context, emailFocusNote, passwordFocusNote);
                    }),
                    focusNode: emailFocusNote,
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
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Password',
                      style: TextStyle(color: AppValues.textColor),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ValueListenableBuilder(
                      valueListenable: obsecurePassword,
                      builder: (context, value, child) {
                        return TextFormField(
                          cursorColor: AppValues.textColor,
                          style: TextStyle(color: AppValues.textColor),
                          onFieldSubmitted: ((value) {
                            Util.fieldFocusChange(context, passwordFocusNote,
                                passwordConfirmFocusNote);
                          }),
                          focusNode: passwordFocusNote,
                          obscureText: value,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^((?=\S*?[A-Z])(?=\S*?[a-z])(?=.*[!@#$%^&*])(?=\S*?[0-9]).{6,})\S$')
                                    .hasMatch(value)) {
                              return 'Please Enter Password';
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Abcde@123',
                            hintStyle: TextStyle(color: AppValues.textColor),
                            suffixIcon: obsecurePassword.value
                                ? IconButton(
                                    onPressed: () {
                                      obsecurePassword.value =
                                          !obsecurePassword.value;
                                    },
                                    icon: Icon(Icons.visibility_off_outlined,
                                        color: AppValues.textColor))
                                : IconButton(
                                    onPressed: () {
                                      obsecurePassword.value =
                                          !obsecurePassword.value;
                                    },
                                    icon: Icon(Icons.visibility_outlined,
                                        color: AppValues.textColor)),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppValues.barColor,
                          ),
                        );
                      }),
                  SizedBox(height: 4.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ForgotScreen())));
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppValues.textColor),
                        )),
                  ),
                  SizedBox(height: 50.h),
                  Button(
                      loading: context.watch<AuthenticationService>().isLoading,
                      title: 'Login',
                      pressed: () {
                        isChecking(context);
                      }),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<AuthenticationService>()
                              .signUpWithGoogle(context);
                        },
                        child: Image(
                            height: 60.h,
                            width: 60.w,
                            image: const AssetImage('assets/google.png')),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const LoginwithNumberScreen())));
                        },
                        child: Image(
                            height: 35.h,
                            width: 60.w,
                            image: const AssetImage('assets/mobile.png')),
                      )
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            color: AppValues.textColor, fontSize: 18.sp),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return const SignUpScreen();
                            })));
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                color: AppValues.textColor, fontSize: 20.sp),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  isChecking(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationService>().login(
          emailController.text.toString(),
          passwordController.text.toString(),
          context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNote.dispose();
    passwordFocusNote.dispose();
    super.dispose();
  }
}
