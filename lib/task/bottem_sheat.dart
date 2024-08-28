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
import 'elvated_task.dart';

class BottemSheet extends StatefulWidget {
  const BottemSheet({super.key});

  @override
  State<BottemSheet> createState() => _BottemSheetState();
}

class _BottemSheetState extends State<BottemSheet> {
  TextEditingController titleTextController  = TextEditingController();
  TextEditingController descriptionTextController  = TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectdate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20) ,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.backGroundlight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                defultTextFiled(
                  controller: titleTextController,
                  hintText: "Enter Task Title",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title cannot be empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                defultTextFiled(
                  controller: descriptionTextController,
                  hintText: "Enter Task Description",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
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
                      selectdate = dataTime;
                      setState(() {});
                    }
                  },
                  child: Text(
                    dateFormat.format(selectdate),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                elvatedBotten(
                  onPressed: () {

                    if (formKey.currentState!.validate()) {
                      addTask();
                    }
                  },
                  label: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addTask() {
    FireBaseFunction.addtaskFromFireBase(
        TaskModel(
          title: titleTextController.text,
          date: selectdate,
          descreption: descriptionTextController.text,
        ),
        Provider.of<userProvider>(context, listen: false).currentUser!.id
    ).catchError((error) {
      Fluttertoast.showToast(
        msg: "Error, please try again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error);
    }).then((_) {
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false)
          .getTask(Provider.of<userProvider>(context, listen: false)
          .currentUser!.id);

      Fluttertoast.showToast(
        msg: "Task Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }


}
