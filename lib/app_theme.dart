import 'package:flutter/material.dart';

class AppTheme  {
  static Color primary = const Color(0xff1E1E1E);
  static Color backGroundlight = const Color(0xff5D9CEC);
  static Color backGrounddark = const Color(0xff141922);
  static Color gery = const Color(0xffC8C9CB);
  static Color green = const Color(0xffDFECDB);
  static Color red = const Color(0xffEC4B4B);
  static Color white = const Color(0xffFFFFFF);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true
      ),
      scaffoldBackgroundColor: backGroundlight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: white,
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: white,
          shape: CircleBorder(
              side: BorderSide(color: white,
                width: 4,)
          )
      ),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:  primary
          ),
          titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: backGrounddark
          )

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              fixedSize: const Size(double.infinity, 52),
              textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: white
              )
          )
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: AppTheme.primary
          )
      )
  );

  static ThemeData darkTheme = ThemeData();

}
