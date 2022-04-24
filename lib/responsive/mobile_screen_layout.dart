import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/models/user_model.dart' as user_model;
import 'package:instagram_flutter_clone/utils/colors.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../resources/auth_methods.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  void logOutUser() async {
    await AuthMethods().logOutUser();
  }

  @override
  Widget build(BuildContext context) {
    user_model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: mobileBgColor,
      appBar: AppBar(
        title: const Text("Mobile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Username : ${user!.username}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: logOutUser,
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
    );
  }
}
