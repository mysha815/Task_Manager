import 'package:flutter/material.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/Widgets/snack_ber_message.dart';

import '../Widgets/tm_app_bar.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(),
      body: Form(
        key: _fromKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 18,right: 18),
              child: Text('Add New Task',style: Theme.of(context).textTheme.titleLarge,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              child: TextFormField(
                controller: _titleTEController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Title'
                ),
                validator: (String? value){
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your title';
                  }
                  return null;
                },
              ),
            ),



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 0),
              child: TextFormField(
                controller: _descriptionTEController,
                maxLines: 9,
                decoration: InputDecoration(
                  hintText: 'Description',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 12)

                ),
                validator: (String? value){
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your description';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: 15,),

            Visibility(
              visible: _addNewTaskInProgress == false,
                replacement:Center(
                  child: CircularProgressIndicator(),
                ),
                child: FilledButton(
                    onPressed:_onTapAddButton, child: Icon(Icons.arrow_circle_right_outlined)
                )
            )
          ],
        ),
      ),
    );
  }

  void _onTapAddButton() {
    if (_fromKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async{
    _addNewTaskInProgress = true;
    setState(() {

    });

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };
    final ApiResponse response = await ApiCaller.postRequest(url: Urls.createTaskUrl,body: requestBody);

    _addNewTaskInProgress = false;
    setState(() {

    });

    if (response.isSuccess){
      _clearTextFields();
      showSnackbarMessage(context, 'New task has been added');
    }else {
      showSnackbarMessage(context, response.errorMessage!);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    _titleTEController.dispose();
    super.dispose();
  }
}
