import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/utils/dimensions.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveLayout(
      {Key? key, required this.mobileLayout, required this.webLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If screen width exceeds the maximum width of
        // 600 then it renders web layout, else mobileLayout.
        if (constraints.maxWidth > webScreenWidth) {
          return widget.webLayout;
        } else {
          return widget.mobileLayout;
        }
      },
    );
  }
}
