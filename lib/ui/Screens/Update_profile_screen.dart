import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/Widgets/screen_background.dart';
import 'package:task_manager/ui/Widgets/tm_app_bar.dart';

import '../Widgets/Photo_Picker_field.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/updateProfile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(
        fromUpdatedProfile: true,
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24,),
                 Text('Update Profile',style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 24,),
                  PhotoPickerField(
                    onTap: _pickImage,
                    selectedPhoto: _selectedImage,
                  ),
                  const SizedBox(height: 8,),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async{
    XFile? PickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (PickedImage  != null){
      _selectedImage = PickedImage;
      setState(() {

      });
    }
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


