import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login.dart';
import 'package:todo/auth/user_provider.dart';
import '../app_theme.dart';
import '../firebase_function.dart';
import '../home.dart';
import '../task/defult_text_filed.dart';
import '../task/elvated_task.dart';

class registerScreen extends StatefulWidget {
  static const String routeName = '/';

  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.green,
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defultTextFiled(
                controller: name,
                hintText: ' User Name ',
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .length < 3) {
                    return "Name Cannot Less Than 3 Characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              defultTextFiled(
                controller: email,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .length < 5) {
                    return "e-mail Cannot Less Than 5 Characters ";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              defultTextFiled(
                controller: password,
                hintText: 'Your Password',
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .length < 8) {
                    return 'Password cannot be Less Than 8 characters ';
                  }
                  return null;
                }, isPassword: true,
              ),

              const SizedBox(height: 32,),
              elvatedBotten(onPressed: register,
                label: 'Create Account',),
              const SizedBox(height: 32,),
              TextButton(onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    loginScreen.routeName);
              },
                  child: const Text ('Already Have an Account ?')
              )
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FireBaseFunction.register(name: name.text,
          email: email.text, password: password.text).then((user) {
        Provider.of<userProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
      }).catchError((

          error) {
        String? message;
        if(error is FirebaseAuthException) {
          message = error.message;
        }

        Fluttertoast.showToast(
            msg: message?? "SomeThing Went Wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.grey,
            textColor: AppTheme.red,
            fontSize: 16.0
        );
      });
    }
  }
}
