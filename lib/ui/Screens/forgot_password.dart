import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';

import 'OTP_Screen.dart';
import 'login_screen.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 82,),
                  Text(
                    ' Your Email Address',
                    style:Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 4,),

                  Text(
                    ' A 6 digits OTP  Will be sent to your email address',
                    style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey
                    ),
                  ),

                  SizedBox(height: 24,),

                  TextFormField(
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),

                  SizedBox(height: 16,),

                  FilledButton(
                      onPressed: _onTapPINButton,
                      child: Icon(Icons.arrow_circle_right_outlined)),

                  SizedBox(height: 36,),

                  Center(
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                          text: "Already have an account?",
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(color: Colors.green),
                                  recognizer: TapGestureRecognizer()..onTap = _onTapLoginButton,
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
    );
  }


void _onTapLoginButton (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen ()));
}

  void _onTapPINButton (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
