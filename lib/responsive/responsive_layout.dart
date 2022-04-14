import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget webLayout;
  const ResponsiveLayout(
      {Key? key, required this.mobileLayout, required this.webLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If screen width exceeds the maximum width of
        // 600 then it renders web layout, else mobileLayout.
        if (constraints.maxWidth > webScreenWidth) {
          return webLayout;
        } else {
          return mobileLayout;
        }
      },
    );
  }
}
