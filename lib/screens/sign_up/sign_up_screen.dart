import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter_clone/resources/auth_methods.dart';
import 'package:instagram_flutter_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter_clone/responsive/responsive_layout.dart';
import 'package:instagram_flutter_clone/utils/utils.dart';
import 'package:instagram_flutter_clone/widgets/profile_pic.dart';
import 'package:instagram_flutter_clone/widgets/text_input_field.dart';
import '../../responsive/web_screen_layout.dart';
import '../../utils/colors.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

  @mustCallSuper
  void didUpdateWidget(Type oldWidget) {}
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  // Loading for Firebase Auth
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        imageFile: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'User Added Successfully') {
      showSnackBar(context, res);
    } else {
      showSnackBar(context, "Account Created Successfully");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileLayout: MobileScreenLayout(),
            webLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // body: Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   width: double.infinity,
          //   height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // To increase the height.
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              const SizedBox(
                height: 40,
              ),
              // Insta Logo
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 24),
              // Profile Image Upload
              ProfilePic(
                imageRadius: 66,
                thickness: 4,
                icon: Icons.add_a_photo_outlined,
                onPress: selectImage,
                imageSource: _image,
                backgroundColor: primaryColor,
              ),
              const SizedBox(height: 24),
              // TextField for email
              TextInputField(
                controller: _emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              // TextField for username
              TextInputField(
                controller: _usernameController,
                hintText: "Username",
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              // TextField for password
              TextInputField(
                controller: _passController,
                isPass: true,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              // TextField for Bio
              TextInputField(
                controller: _bioController,
                hintText: 'Add Bio',
                maxLines: 4,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 24),
              // Login Button
              InkWell(
                onTap: signUpUser,
                child: _isLoading
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                          color: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: blueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Center(
                          child: Text("Sign Up"),
                        ),
                      ),
              ),
              // Move to Sign Up if doesn't have an account already
              const SizedBox(height: 12),
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account, Click here to",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: navigateToLogin,
                    child: const Text("Log In"),
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
