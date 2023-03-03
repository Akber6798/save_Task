import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:save_task/screens/home_screen/home_screen.dart';
import 'package:save_task/screens/note_screen/note_screen.dart';
import 'package:save_task/screens/profile_screen.dart/profile_screen.dart';
import 'package:save_task/utilities/appvalues.dart';

class BottomScreenController extends StatefulWidget {
  BottomScreenController({super.key});

  @override
  State<BottomScreenController> createState() => _BottomScreenControllerState();
}

class _BottomScreenControllerState extends State<BottomScreenController> {
  List<Widget> screens = [const HomeScreen(),ProfileScreen(),NoteScreen()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          index: currentIndex,
          backgroundColor: AppValues.backGroundColor,
          color: AppValues.barColor,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            Icon(Icons.home, size: 30, color: AppValues.textColor),
            Icon(Icons.person, size: 30, color: AppValues.textColor),
            Icon(Icons.add, size: 30, color: AppValues.textColor),
          ]),
    );
  }
}
