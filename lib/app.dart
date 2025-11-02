import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/ui/Screens/Update_profile_screen.dart';
import 'package:task_manager/ui/Screens/login_screen.dart';
import 'package:task_manager/ui/Screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager/ui/Screens/sign_Upscreen.dart';
import 'package:task_manager/ui/Screens/splash_screen.dart';
import 'package:task_manager/ui/controller/login_provider.dart';
import 'package:task_manager/ui/controller/new_task_list_provider.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewTaskListProvder()),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
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

        initialRoute: SplashScreen.name,
        routes: {
          SplashScreen.name: (_) => SplashScreen(),
          LoginScreen.name: (_) => LoginScreen(),
          SignUpscreen.name: (_) => SignUpscreen(),
          MainNavBarHolderScreen.name: (_) => MainNavBarHolderScreen(),
          UpdateProfileScreen.name: (_) => UpdateProfileScreen(),

        },

        debugShowCheckedModeBanner: false,


      ),
    );
  }
}
