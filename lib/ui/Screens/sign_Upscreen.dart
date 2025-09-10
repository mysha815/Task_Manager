import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';

import 'login_screen.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
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
                      'Join With Us',
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
                      controller: _firstNameTEController,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    SizedBox(height: 8,),
            
                    TextFormField(
                      controller: _mobileTEController,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
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
                        onPressed: (){},
                        child: Icon(Icons.arrow_circle_right_outlined)),
            
                    SizedBox(height: 36,),
            
                    Center(
                      child: Column(
                        children: [
                          TextButton(onPressed: (){}, child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          )),
                          RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                            text: "Already have an account?",
                                children: [
                                  TextSpan(
                                    text: 'Sign in',
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
      ),
    );
  }
void _onTapLoginButton (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen ()));
}

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    super.dispose();
  }
}
