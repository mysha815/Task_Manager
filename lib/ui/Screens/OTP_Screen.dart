import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Reset_password_screen.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _OtpTEController = TextEditingController();
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
                    'PIN Verification',
                    style:Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digit Verification pin Will send to your  email address',
                    style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                    ),
                  ),

                  SizedBox(height: 24,),

                  PinCodeTextField(
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      controller: _OtpTEController,
                      appContext: context,
                      length: 6),


                  SizedBox(height: 16,),

                  FilledButton(
                      onPressed: _onTapVerifyButton,
                      child: Text('Verify')
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

  void _onTapVerifyButton (){
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) =>ResetPassword ()),
          (predicate) => false,
    );
  }


  @override
  void dispose() {
    _OtpTEController.dispose();
    super.dispose();
  }
}
