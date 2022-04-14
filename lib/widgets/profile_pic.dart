import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/utils/colors.dart';

class ProfilePic extends StatelessWidget {
  final double imageRadius;
  final double thickness;
  final IconData icon;
  final void Function()? onPress;
  final Uint8List? imageSource;
  final Color? backgroundColor;

  const ProfilePic(
      {Key? key,
      required this.imageRadius,
      required this.thickness,
      required this.icon,
      required this.onPress,
      required this.backgroundColor,
      required this.imageSource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            radius: imageRadius + thickness + 4,
            backgroundColor: backgroundColor,
            child: CircleAvatar(
              radius: 4 + imageRadius,
              backgroundColor: blackColor,
              child: imageSource != null
                  ? CircleAvatar(
                      radius: imageRadius,
                      backgroundImage: MemoryImage(imageSource!),
                    )
                  : CircleAvatar(
                      radius: imageRadius,
                      backgroundImage: const NetworkImage(
                        "https://images.pexels.com/photos/2669797/pexels-photo-2669797.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                      ),
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: CircleAvatar(
            backgroundColor: primaryColor,
            child: IconButton(
              onPressed: onPress,
              icon: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }
}
