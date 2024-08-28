import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../app_theme.dart';
import '../auth/task_provider.dart';
import '../auth/user_provider.dart';
import '../firebase_function.dart';
import '../model/task_model.dart';
import 'defult_text_filed.dart';

class editTask extends StatefulWidget {
  static const String routeName = '/editTask';

  const editTask({super.key});

  @override
  State<editTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<editTask> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.green,
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit Task',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  defultTextFiled(
                    controller: title,
                    hintText: 'This is Title',

                  ),
                  const SizedBox(height: 10),
                  defultTextFiled(
                    controller: description,
                    hintText: 'Edit Description',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Select A Date",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      DateTime? dataTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        initialDate: DateTime.now(),
                      );
                      if (dataTime != null) {
                        setState(() {
                          selectDate = dataTime;
                        });
                      }
                    },
                    child: Text(
                      dateFormat.format(selectDate),

                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        addTask();
                      }
                    },
                    child: const Text("Save Changes"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addTask() {
    FireBaseFunction.addtaskFromFireBase(
        TaskModel(
          title: title.text,
          date: selectDate,
          descreption: description.text,
        ),
        Provider.of<userProvider>(context, listen: false).currentUser!.id)
        .catchError((error) {
      Fluttertoast.showToast(
        msg: "Error, please try Again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error);
    }).timeout(
      const Duration(seconds: 500),
      onTimeout: () {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTask(Provider.of<userProvider>(context).currentUser!.id);
        Fluttertoast.showToast(
          msg: "Task Edited Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    );
  }
}
