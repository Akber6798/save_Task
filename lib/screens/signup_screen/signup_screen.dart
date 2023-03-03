import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:save_task/screens/auth_provider.dart';
import 'package:save_task/screens/login_screen/login_screen.dart';
import 'package:save_task/utilities/appvalues.dart';
import 'package:save_task/utilities/refactor_widgets/button.dart';
import 'package:save_task/utilities/util.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
ValueNotifier<bool> obsecurePassword = ValueNotifier(true);
ValueNotifier<bool> obsecureConfirmPassword = ValueNotifier(true);
FocusNode emailFocusNote = FocusNode();
FocusNode passwordFocusNote = FocusNode();
FocusNode passwordConfirmFocusNote = FocusNode();

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
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
                      'Create account',
                      style: TextStyle(
                          fontSize: 25.sp, color: AppValues.textColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Start save your notes!',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: AppValues.textColor,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                  SizedBox(height: 20.h),
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
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(color: AppValues.textColor),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ValueListenableBuilder(
                      valueListenable: obsecureConfirmPassword,
                      builder: (context, value, child) {
                        return TextFormField(
                          cursorColor: AppValues.textColor,
                          style: TextStyle(color: AppValues.textColor),
                          focusNode: passwordConfirmFocusNote,
                          obscureText: value,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^((?=\S*?[A-Z])(?=\S*?[a-z])(?=.*[!@#$%^&*])(?=\S*?[0-9]).{6,})\S$')
                                    .hasMatch(value)) {
                              return 'Please re enter your Password';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Abcde@123',
                            hintStyle: TextStyle(color: AppValues.textColor),
                            suffixIcon: obsecureConfirmPassword.value
                                ? IconButton(
                                    onPressed: () {
                                      obsecureConfirmPassword.value =
                                          !obsecureConfirmPassword.value;
                                    },
                                    icon: Icon(Icons.visibility_off_outlined,
                                        color: AppValues.textColor))
                                : IconButton(
                                    onPressed: () {
                                      obsecureConfirmPassword.value =
                                          !obsecureConfirmPassword.value;
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
                  SizedBox(height: 50.h),
                  Button(
                      loading: context.watch<AuthenticationService>().isLoading,
                      title: 'Sign up',
                      pressed: () {
                        isChecking(context);
                      }),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                            color: AppValues.textColor, fontSize: 18.sp),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const LoginScreen())));
                          },
                          child: Text(
                            'Login',
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
      context.read<AuthenticationService>().signUp(
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
    passwordConfirmFocusNote.dispose();
    super.dispose();
  }
}
