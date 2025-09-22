import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';
import 'package:task_manager/ui/Widgets/snack_ber_message.dart';

import 'login_screen.dart';

class SignUpscreen extends StatefulWidget {
  const SignUpscreen({super.key});

  static const String name = '/signup';

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

  bool _signUpInProgress = false;

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value){
                        String inputText = value ?? '';
                        if (EmailValidator.validate(inputText) == false){
                          return 'Enter a vaild email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
            
                    TextFormField(
                      controller: _firstNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String? value){
                        if (value?.trim().isEmpty ?? true){
                          return 'Enter a first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: _lastNameTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (String? value){
                        if (value?.trim().isEmpty ?? true){
                          return 'Enter a last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8,),
            
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value){
                        if (value?.trim().isEmpty ?? true){
                          return 'Enter your mobile';
                        }
                        return null;
                      },
                    ),
            
                    SizedBox(height: 8,),
            
                    TextFormField(
                      controller: _passwordTEController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if ((value?.length ?? 0) <= 6){
                          return 'Enter your password more than 6 letters';
                        }
                        return null;
                      },
                    ),
            
                    SizedBox(height: 16,),
            
                    Visibility(
                      visible: _signUpInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: FilledButton(
                          onPressed: _onTapSubmitButton,
                          child: Icon(Icons.arrow_circle_right_outlined)),
                    ),
            
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

  void _onTapSubmitButton() {
    if (_fromKey.currentState!.validate()){
      _signUp();
    }
  }

void _onTapLoginButton (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen ()));

}

Future<void> _signUp()async{
   _signUpInProgress = true;
   setState(() {

   });
   Map<String,dynamic> requestBody = {
     "email":_emailTEController.text.trim(),
     "firstName":_firstNameTEController.text.trim(),
     "lastName":_lastNameTEController.text.trim(),
     "mobile":_mobileTEController.text.trim(),
     "password":_passwordTEController.text
   };
   final ApiResponse response = await ApiCaller.postRequest(
       url: Urls.regestrationUrl,
     body: requestBody
   );
   _signUpInProgress = false;
   setState(() {

   });
   if(response.isSuccess){
     _clearTextFields();
     showSnackbarMessage(context,'Registration success! please login');
   }else{
     showSnackbarMessage(context,response.errorMessage!);
   }
}

void _clearTextFields(){
  _emailTEController.clear();
  _passwordTEController.clear();
  _firstNameTEController.clear();
  _lastNameTEController.clear();
  _mobileTEController.clear();
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
