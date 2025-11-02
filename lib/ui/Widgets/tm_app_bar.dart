import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/ui/Screens/login_screen.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

import '../Screens/Update_profile_screen.dart';

class TMAppbar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppbar({
    super.key,
    this.fromUpdatedProfile,
  });

  final bool? fromUpdatedProfile;

  @override
  State<TMAppbar> createState() => _TMAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppbarState extends State<TMAppbar> {
  @override
  Widget build(BuildContext context) {
    final profilePhoto = AuthController.userModel!.photo;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (widget.fromUpdatedProfile ?? false) {
            return;
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        },
        child: Row(
          children: [
            CircleAvatar(
              child: profilePhoto.isNotEmpty
                  ? Image.memory(
                  jsonDecode(profilePhoto))
                  : Icon(Icons.person),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? '',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  AuthController.userModel?.email ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [IconButton(onPressed: _signOut, icon: Icon(Icons.logout))],
    );
  }

  Future<void> _signOut() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.name, (predicate) => false);
  }
}
