import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter_clone/responsive/responsive_layout.dart';
import 'package:instagram_flutter_clone/responsive/web_screen_layout.dart';
import 'package:instagram_flutter_clone/screens/login/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                webLayout: WebScreenLayout(),
                mobileLayout: MobileScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Please close the app and try again."),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return const LoginScreen();
        },
      ), // SignUpScreen()
    );
  }
}
