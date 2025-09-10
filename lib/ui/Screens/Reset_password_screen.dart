import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
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
                    'Set Password',
                    style:Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Minimum length password 8 character with letter and number combination',
                    style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                    ),
                  ),


                  SizedBox(height: 24,),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: ' Password'
                    ),
                  ),
                  SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                  ),


                  SizedBox(height: 16,),

                  FilledButton(
                      onPressed: _onTapResetButton,
                      child: Text('Confirm')
                  ),

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
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen ()),
        (predicate) => false,
    );
}

  void _onTapResetButton (){
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => LoginScreen ()),
          (predicate) => false,
    );
  }


  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
