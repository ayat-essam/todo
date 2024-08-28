import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/register.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/task/elvated_task.dart';
import '../app_theme.dart';
import '../firebase_function.dart';
import '../home.dart';
import '../task/defult_text_filed.dart';

class loginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';

  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.green,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defultTextFiled(
                controller: emailController,
                hintText: 'Email',
                validator: (value){
                  if(value == null || value.trim().length < 5){
                    return "e-mail Cannot Less Than 5 Characters ";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              defultTextFiled(
                controller: passwordController,
                hintText: 'Your Password',
                validator: (value){
                  if(value == null || value.trim().length < 8){
                    return 'Password cannot be Less Than 8 characters ';
                  }return null;
                },isPassword: true,
              ),

              const SizedBox(height: 32,),
              elvatedBotten(onPressed: login,
                label: 'Login',),
              const SizedBox(height: 32,),
              TextButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed(registerScreen.routeName);
              },
                  child: const Text ('Do You Have an Account ?')
              )
            ],
          ),
        ),
      ),
    );
  }
  void login (){
    if(formKey.currentState!.validate()){
      FireBaseFunction.login(email: emailController.text, password: passwordController.text).catchError((error){
        Fluttertoast.showToast(
            msg: "SomeThing went wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppTheme.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }).then((user) {
        Provider.of<userProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
      });
    }
  }
}

