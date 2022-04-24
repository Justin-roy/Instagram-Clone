import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: const Text('This Is Web Screen'),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/insta_word_icon.png',
          color: Colors.white,
        ),
      ),
    );
  }
}
