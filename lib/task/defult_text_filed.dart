import 'package:flutter/material.dart';
class defultTextFiled extends StatefulWidget {
  String hintText ;
  int? maxLines;
  String? Function(String?)? validator;
  TextEditingController controller;
  bool isPassword ;
  defultTextFiled({super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
    this.isPassword = false
  });

  @override
  State<defultTextFiled> createState() => _defultTextFiledState();
}

class _defultTextFiledState extends State<defultTextFiled> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hintText,
          suffixIcon: widget.isPassword? IconButton
            (icon: Icon(
              isObscure ? Icons.visibility_off_outlined:
              Icons.visibility) ,color:Colors.black38 ,onPressed:(){
            isObscure =! isObscure;
            setState(() {

            });
          } ,)
              :null
      ),
      minLines: 1,
      maxLines: widget.maxLines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObscure,
    );
  }
}
