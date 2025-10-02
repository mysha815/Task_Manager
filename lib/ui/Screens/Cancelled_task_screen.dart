import 'package:flutter/material.dart';

import '../Widgets/TaskCard.dart';
import '../Widgets/screen_background.dart';
import '../Widgets/task_count_by_status_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Expanded(
              child: Card(
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context,index){
                   // return const TaskCard(title: 'Cancelled', rowcolor: Colors.red,);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 8,);
                  },
                
                ),
              )
          ),
        ),
      ),



    );
  }
}




