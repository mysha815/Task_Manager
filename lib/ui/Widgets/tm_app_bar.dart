import 'package:flutter/material.dart';
class TMAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
              ),),
              Text('email@gmail.com',style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),),
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.logout))
      ],
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}