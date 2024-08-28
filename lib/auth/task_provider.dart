import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../firebase_function.dart';
import '../model/task_model.dart';

class TasksProvider with ChangeNotifier{
  List<TaskModel> tasks = [];
  DateTime selectdate = DateTime.now();
  List<TaskModel> get task => tasks;

  Future<void> updateTask(TaskModel task, String userId) async {
    await FireBaseFunction.updateTask(task,userId);
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      notifyListeners();
    }
  }
  void deleteTask(String taskId, String userId) async {
    try {
      await FireBaseFunction.deletetaskfromfirebase(taskId, userId);

      await fetchTasks(userId);

      Fluttertoast.showToast(
        msg: "Task Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error, please try again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Error deleting task: $error");
    }
  }



  Future<void> fetchTasks(String userId) async {
    tasks = await FireBaseFunction.getAllTaskFromFireBase(userId);
    notifyListeners();
  }

  Future<void> getTask(String userId)async{
    List<TaskModel> allTasks = await FireBaseFunction.getAllTaskFromFireBase(userId);
    tasks = allTasks.where((task) =>
    task.date.day==selectdate.day &&
        task.date.month == selectdate.month&&
        task.date.year == selectdate.year
    ).toList();
    notifyListeners();
  }

  void changeTime( DateTime time) {
    time = selectdate;
    notifyListeners();
  }
}