import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_flutter_clone/resources/auth_methods.dart';
import 'package:instagram_flutter_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter_clone/responsive/responsive_layout.dart';
import 'package:instagram_flutter_clone/responsive/web_screen_layout.dart';
import 'package:instagram_flutter_clone/screens/sign_up/sign_up_screen.dart';
import 'package:instagram_flutter_clone/utils/colors.dart';
import 'package:instagram_flutter_clone/utils/utils.dart';
import 'package:instagram_flutter_clone/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @mustCallSuper
  void didUpdateWidget(Type oldWidget) {}
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  // Loading for Firebase
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passController.text
    );

    setState(() {
      _isLoading = false;
    });

    if (res == "Success") {
      showSnackBar(
          context, "Logged in as ${_auth.currentUser!.email.toString()}");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileLayout: MobileScreenLayout(),
            webLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // To increase the height.
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // Insta Logo
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 60),
              // TextField for email
              TextInputField(
                controller: _emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // TextField for password
              TextInputField(
                controller: _passController,
                isPass: true,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 24),
              // Login Button
              InkWell(
                onTap: loginUser,
                child: _isLoading
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Center(
                          child: Text("Log In"),
                        ),
                      ),
              ),
              // Move to Sign Up if doesn't have an account already
              const SizedBox(height: 12),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account, Click here to",
                    style: TextStyle(color: primaryColor70),
                  ),
                  TextButton(
                    onPressed: navigateToSignUp,
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
