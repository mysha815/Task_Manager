import 'package:flutter/material.dart';

import '../Widgets/TaskCard.dart';
import '../Widgets/task_count_by_status_card.dart';
import 'add_new.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16,),
            SizedBox(
              height: 90,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) {
                  return TaskCountByStatusCard(
                    title:'New',
                    count: 2,
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(width: 4,);
                },
              ),
            ),
            Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return TaskCard(title: 'New', rowcolor: Colors.green,);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 8,);
                  },

                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNew()));
      },child: Icon(Icons.add),),


    );
  }
}






