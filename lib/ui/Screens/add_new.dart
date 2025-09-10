import 'package:flutter/material.dart';

import '../Widgets/tm_app_bar.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(),
      body: Form(
        key: _fromKey,
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
                controller: _subjectTEController,
                decoration: InputDecoration(
                  hintText: 'Subject'
                ),
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
              ),
            ),

            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FilledButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}
