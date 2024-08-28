import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/task/edit_task.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../app_theme.dart';
import '../auth/task_provider.dart';
import '../auth/user_provider.dart';
import 'elvated_bottem.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool shouldGetTask = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (shouldGetTask){
      tasksProvider.getTask(Provider
          .of<userProvider>(context)
          .currentUser!
          .id);
    } shouldGetTask = false;
    return Column (

      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: screenHeight * 0.25,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            PositionedDirectional(
              start: 20,
              top: 50,
              child: Text('ToDo'
                // AppLocalizations.of(context)!.todolist,
                // style: Theme.of(context).textTheme.titleMedium?.copyWith(
                //   fontSize: 20,
                //   color: AppTheme.white,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.08),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(const Duration(days: 30)),
                focusDate: tasksProvider.selectdate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                showTimelineHeader: false,
                onDateChange: (selectdate) {
                  tasksProvider.changeTime(selectdate);
                  tasksProvider.getTask( Provider.of<userProvider>(context, listen: false).currentUser!.id);

                },
                activeColor: AppTheme.primary,
                dayProps: EasyDayProps(
                  height: 90,
                  width: 60,
                  dayStructure: DayStructure.dayNumDayStr,
                  activeDayStyle:  DayStyle(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    dayStrStyle: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                    dayNumStyle: TextStyle(color:AppTheme.green, fontWeight: FontWeight.bold, fontSize: 32),
                    monthStrStyle: TextStyle(color: Colors.transparent),
                  ),
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                    dayNumStyle: TextStyle(color:AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 32),
                    monthStrStyle: const TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                 editTask.routeName,
                  arguments: tasksProvider.tasks[index],
                );
              },
              child: TaskItem(tasksProvider.tasks[index]),
            ),
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            padding: const EdgeInsets.only(top: 16),
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
