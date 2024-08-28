import 'package:flutter/material.dart';

import '../app_theme.dart';

class  elvatedBotten extends StatelessWidget {
  final String label;
  final  VoidCallback onPressed;
  const elvatedBotten({super.key,
    required this.onPressed,
    required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 52)
      ),
      child: Text(label,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400,color: AppTheme.white)) ,
    );
  }
}
