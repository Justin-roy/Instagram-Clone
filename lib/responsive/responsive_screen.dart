import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // return web screen size
          return webScreenLayout;
        }
        // Otherwise return mobile screen size
        return mobileScreenLayout;
      }),
    );
  }
}
