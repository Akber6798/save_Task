class TaskModel {
  final int? id;
  final String title;
  final String note;
  final String dateAndTime;

  TaskModel({this.id,required this.title,required this.note,required this.dateAndTime});

  TaskModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        note = res['note'],
        dateAndTime = res['dateAndTime'];

  Map<String, Object?> toMap() {
    return {"id": id, "title": title, "note": note, "dateAndTime": dateAndTime};
  }
}
