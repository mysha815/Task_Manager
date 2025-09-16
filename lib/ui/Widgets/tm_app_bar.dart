import 'package:flutter/material.dart';

import '../Screens/Update_profile_screen.dart';
class TMAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppbar({
    super.key, this.fromUpdatedProfile,
  });

  final bool? fromUpdatedProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: (){

          if(fromUpdatedProfile ?? false){
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        },
        child: Row(
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
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.logout))
      ],
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}