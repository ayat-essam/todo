import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/task/edit_task.dart';
import 'app_theme.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'auth/task_provider.dart';
import 'auth/user_provider.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBOa__GYTXvXAGfEgL8YIIxYu-sOqzwssg",
      appId: "1:40176305972:android:33825bb06741fb27864761",
      messagingSenderId: "40176305972",
      projectId: "todo-test-b2f8b",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TasksProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => userProvider(), // Ensure this is the correct class name
        ),
      ],
      child: const Todo(),
    ),
  );
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routName: (_) => const HomeScreen(),
        registerScreen.routeName: (_) => const registerScreen(),
        loginScreen.routeName: (_) => const loginScreen(),
        '/editTask': (context) => const editTask(),
      },
      initialRoute: loginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      // locale: Locale(Setting.language),
    );
  }
}



