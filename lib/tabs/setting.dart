import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login.dart';
import '../auth/task_provider.dart';
import '../auth/user_provider.dart';
import '../firebase_function.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logout',
                    style: Theme.of(context).textTheme.titleMedium),
                IconButton(onPressed: (){
                  FireBaseFunction.logout();
                  Navigator.of(context).pushReplacementNamed(loginScreen.routeName);
                  Provider.of<TasksProvider>(context, listen: false).tasks.clear();
                  Provider.of<userProvider>(context, listen: false).updateUser(null);
                }, icon: Icon(Icons.logout_outlined,size: 28,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
