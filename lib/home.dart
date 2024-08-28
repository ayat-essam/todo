
import 'package:flutter/material.dart';
import 'package:todo/tabs/setting.dart';
import 'package:todo/task/bottem_sheat.dart';
import 'package:todo/task/tasks.dart';

import 'app_theme.dart';


class HomeScreen extends StatefulWidget {
  static const String routName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex =0;
  List<Widget> tabs = [
    const Tasks(),
    const Setting()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.green,
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: AppTheme.white,
        color: AppTheme.white,

        child: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (index){
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [


            BottomNavigationBarItem(
                label: "Tasks",
                icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings)),



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(context:context,
            isScrollControlled: true,
            builder: (_) => const BottemSheet()),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
