import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:save_task/DataBase/data_base_service.dart';
import 'package:save_task/model_class/model_class.dart';
import 'package:save_task/screens/note_screen/note_screen.dart';
import 'package:save_task/utilities/appvalues.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _dbHelper = DatabaseService();
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
                  TextButton(onPressed: () {
                    SystemNavigator.pop();
                  }, child: const Text('Yes')),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text('No')),
                ],
              );
            }));

        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppValues.backGroundColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Save Note',
              style: TextStyle(color: AppValues.textColor),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  FutureBuilder<List<TaskModel>>(
                      future: _dbHelper.getData(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return MasonryGridView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: ((context, index) {
                                var value = snapshot.data![index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 2, color: AppValues.barColor)),
                                  color: AppValues.backGroundColor,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        Text(
                                          value.dateAndTime,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w300,
                                              color: AppValues.textColor),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(value.title,
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppValues.textColor),
                                                textAlign: TextAlign.center,
                                                ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          value.note,
                                          style: TextStyle(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppValues.textColor),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 10.h),
                                        Divider(
                                          color: AppValues.barColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Are you Sure?'),
                                                          content: const Text(
                                                              'Do you really want to delete this note'),
                                                          actions: [
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _dbHelper.deleteData(
                                                                        value
                                                                            .id!
                                                                            .toInt());
                                                                    snapshot
                                                                        .data!
                                                                        .remove(
                                                                            value);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Delete')),
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor:
                                                                        AppValues
                                                                            .barColor,
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel')),
                                                          ],
                                                        );
                                                      }));
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: AppValues.textColor,
                                                  size: 20,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              NoteScreen(
                                                                update: true,
                                                                id: value.id,
                                                                taskTitle:
                                                                    value.title,
                                                                taskNote:
                                                                    value.note,
                                                                updateTime: value
                                                                    .dateAndTime,
                                                              ))));
                                                },
                                                icon: Icon(
                                                  Icons.edit_note,
                                                  color: AppValues.textColor,
                                                  size: 28,
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                      ],
                                    ),
                                  ),
                                );
                              }));
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppValues.textColor,
                            ),
                          );
                        }
                      }))
                ],
              ),
            ),
          )),
    );
  }

 
}
