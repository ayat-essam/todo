
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../auth/user_provider.dart';
import '../firebase_function.dart';

class TaskModel {
  String id;
  String title;
  String descreption;
  bool isDone;
  DateTime date;

  TaskModel({
    required this.title,
    required this.date,
    required this.descreption,
    this.isDone = false,
    this.id = '',
  });


  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ,
        title = json['title'] ,
        descreption = json['descreption'] ,
        date = (json['date'] as Timestamp).toDate(),
        isDone = json['isDone'] ?? false;


  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'descreption': descreption,
    'date': Timestamp.fromDate(date),
    'isDone': isDone,
  };


  factory TaskModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return TaskModel(
      id: snapshot.id,
      title: data['title'] ,
      descreption: data['descreption'] ,
      isDone: data['isDone'] ?? false,
      date: (data['date'] as Timestamp).toDate(),
    );
  }
  Future<void> updateTask(BuildContext context) async {
    await FireBaseFunction.updateTask(
      this,
      Provider.of<userProvider>(context, listen: false).currentUser!.id,
    );
  }


}
