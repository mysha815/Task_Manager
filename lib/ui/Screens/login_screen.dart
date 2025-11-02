import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/Screens/sign_Upscreen.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';
import 'package:task_manager/ui/Widgets/snack_ber_message.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/ui/controller/login_provider.dart';


import 'forgot_password.dart';
import 'main_nav_bar_holder_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

final LoginProvider _loginProvider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _loginProvider,
      child: Scaffold(
        body: ScreenBackground(
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
                      'Get Started With',
                      style:Theme.of(context).textTheme.titleLarge,
                    ),

                    SizedBox(height: 24,),

                    TextFormField(
                      controller: _emailTEController,
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
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if ((value?.length ?? 0) <= 6){
                          return 'password should more than 6 letters';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 16,),

                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, _) {
                        return Visibility(
                          visible: loginProvider.loginInProgress == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: FilledButton(
                              onPressed:_onTapLoginButton,
                              child: Icon(Icons.arrow_circle_right_outlined)),
                        );
                      }
                    ),

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
    if(_fromKey.currentState!.validate()){
      _login();
    }
  }

  Future<void> _login() async{
   final bool isSuccess = await _loginProvider.login(_emailTEController.text.trim(), _passwordTEController.text);
    if(isSuccess){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavBarHolderScreen(),
          ),
          (predicated) => false,
      );

    }else{
      showSnackbarMessage(context, _loginProvider.errorMessage!);
    }
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}


