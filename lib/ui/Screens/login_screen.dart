import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screens/sign_Upscreen.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';

import 'forgot_password.dart';
import 'main_nav_bar_holder_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 82,),
                    Text(
                      'Get Started With',
                      style:Theme.of(context).textTheme.titleLarge,
                    ),

                    SizedBox(height: 24,),

                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),

                    SizedBox(height: 8,),

                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),

                    SizedBox(height: 16,),

                    FilledButton(
                        onPressed:_onTapLoginButton,
                        child: Icon(Icons.arrow_circle_right_outlined)),

                    SizedBox(height: 36,),

                    Center(
                      child: Column(
                        children: [
                          TextButton(onPressed: _forgotPassword, child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          )),
                          RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                            text: "Dont have an account?",
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(color: Colors.green),
                                    recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                                  )
                                ]
                          )
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _forgotPassword(){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>forgotPassword()));
  }

  void _onTapSignUpButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpscreen ()));
  }

  void _onTapLoginButton(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavBarHolderScreen(),
        ),
        (predicated) => false,


    );
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
