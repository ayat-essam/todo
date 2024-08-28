import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../app_theme.dart';
import '../auth/task_provider.dart';
import '../auth/user_provider.dart';
import '../firebase_function.dart';
import '../model/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel taskModel;

  const TaskItem(this.taskModel, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isCompleted = taskModel.isDone;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Slidable(
        key: ValueKey(taskModel.id),
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) async {
                try {
                  final userId = Provider.of<userProvider>(context, listen: false).currentUser!.id;
                  await FireBaseFunction.deletetaskfromfirebase(taskModel.id, userId);
                  await Provider.of<TasksProvider>(context, listen: false).getTask(userId);
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
                    msg: "Something went wrong!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              backgroundColor: Colors.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isCompleted ? AppTheme.green : theme.primaryColor,
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                color: theme.primaryColor,
                margin: const EdgeInsetsDirectional.only(end: 8),
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isCompleted ? AppTheme.green : AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    taskModel.descreption,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: isCompleted ? AppTheme.green : AppTheme.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  try {
                    taskModel.isDone = !taskModel.isDone; // Toggle completion status
                    final userId = Provider.of<userProvider>(context, listen: false).currentUser!.id;
                    await FireBaseFunction.updateTask(taskModel, userId);
                    await Provider.of<TasksProvider>(context, listen: false).getTask(userId);
                  } catch (error) {
                    Fluttertoast.showToast(
                      msg: "Error updating task!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: Container(
                  width: 69,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isCompleted ? AppTheme.green : theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.check,
                    color: isCompleted ? AppTheme.white : Colors.grey,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
