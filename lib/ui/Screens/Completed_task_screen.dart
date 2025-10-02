import 'package:flutter/material.dart';

import '../Widgets/TaskCard.dart';
import '../Widgets/task_count_by_status_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context,index){
                //return const TaskCard(title: 'Completed', rowcolor: Colors.blueAccent,);
              },
              separatorBuilder: (context,index){
                return SizedBox(height: 8,);
              },

            )
        ),
      ),



    );
  }
}




