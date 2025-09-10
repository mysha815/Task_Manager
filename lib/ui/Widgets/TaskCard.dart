import 'package:flutter/material.dart';
class TaskCard extends StatelessWidget {
  final String title;
  final Color rowcolor;
  const TaskCard({
    super.key, required this.title,  required this.rowcolor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      tileColor: Colors.white,
      title: Text('Title will be here'),
      subtitle:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Describtion of task'),
          SizedBox(height: 8,),
          Text('Date:9/8/2025',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),
          ),
          Row(
            children: [
              Chip(
                label: Text(title),backgroundColor: rowcolor,
                labelStyle: TextStyle(
                    color: Colors.white
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                ),

              ),
              Spacer(),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.delete),color: Colors.grey,
                style: IconButton.styleFrom(backgroundColor: Colors.transparent),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.edit),color: Colors.grey,
                style: IconButton.styleFrom(backgroundColor: Colors.transparent),
              ),
            ],
          )

        ],
      ) ,
    );
  }
}