import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:save_task/DataBase/data_base_service.dart';
import 'package:save_task/model_class/model_class.dart';
import 'package:save_task/screens/bottom_controller.dart';
import 'package:save_task/utilities/appvalues.dart';
import 'package:save_task/utilities/util.dart';

class NoteScreen extends StatefulWidget {
  int? id;
  String? taskTitle;
  String? taskNote;
  String? updateTime;
  bool? update;

  NoteScreen(
      {this.id, this.taskTitle, this.taskNote, this.updateTime, this.update});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _dbHelper = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.taskTitle);
    final noteController = TextEditingController(text: widget.taskNote);
    FocusNode titleFocusNote = FocusNode();
    FocusNode noteFocusNote = FocusNode();
    String appBarTitle;
    if (widget.update == true) {
      appBarTitle = 'Update';
    } else {
      appBarTitle = 'Save';
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => BottomScreenController())));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppValues.backGroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => BottomScreenController())));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppValues.textColor,
              )),
          actions: [
            TextButton(
                onPressed: () {
                  if (widget.update == true) {
                    _dbHelper.upDateData(TaskModel(
                        id: widget.id,
                        title: titleController.text,
                        note: noteController.text,
                        dateAndTime:
                            DateFormat('yMd').add_jm().format(DateTime.now())));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => BottomScreenController())));
                    Util().showToast('Task Updated');
                  } else {
                    _dbHelper.insertData(TaskModel(
                        title: titleController.text,
                        note: noteController.text,
                        dateAndTime:
                            DateFormat('yMd').add_jm().format(DateTime.now())));
                    titleController.clear();
                    noteController.clear();
                    Util().showToast('Task Added');
                  }
                },
                child: Text(
                  appBarTitle,
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppValues.textColor),
                )),
            SizedBox(width: 10.w),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              TextFormField(
                focusNode: titleFocusNote,
                onFieldSubmitted: ((value) {
                  Util.fieldFocusChange(context, titleFocusNote, noteFocusNote);
                }),
                cursorColor: AppValues.textColor,
                style: TextStyle(color: AppValues.textColor, fontSize: 22.sp),
                controller: titleController,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Title',
                    hintStyle: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                        color: AppValues.textColor)),
              ),
              TextFormField(
                focusNode: noteFocusNote,
                cursorColor: AppValues.textColor,
                style: TextStyle(color: AppValues.textColor, fontSize: 18.sp),
                controller: noteController,
                maxLines: 10,
                decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Task',
                    hintStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: AppValues.textColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
