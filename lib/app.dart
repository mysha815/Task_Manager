import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screens/splash_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
                color: Colors.grey
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),

        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
          ),
        )
      ),

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
