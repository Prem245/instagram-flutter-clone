import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // Web Layout
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBx1kjY_LvN_yTNE62Rg_4_Ox6f2bclcWo",
        appId: "1:670373148011:web:4c95f4e5419ea66b3a882e",
        messagingSenderId: "670373148011",
        projectId: "instagram-flutter-clone-d34f4",
        storageBucket: "instagram-flutter-clone-d34f4.appspot.com",
      ),
    );
  } else {
    // Mobile Layout
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}
