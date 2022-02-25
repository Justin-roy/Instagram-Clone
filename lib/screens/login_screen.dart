import 'package:flutter/material.dart';
import 'package:instagram_clone/Widgets/bottom_message.dart';
import 'package:instagram_clone/Widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_screen.dart';
import 'package:instagram_clone/screens/signUp_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Initializing TextEditController
  final _email = TextEditingController();
  final _password = TextEditingController();
  // Wait For Result
  bool isLoading = false;
  // Calling Auth Class
  AuthMethods authMethods = AuthMethods();

  // Disposing TextEditController
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  //Calling Auth
  logInUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await authMethods.logInUser(
      email: _email.text,
      password: _password.text,
    );
    setState(() {
      isLoading = false;
    });
    if (res != 'Success') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              //InstaGram Word Image
              Image.asset(
                'assets/images/insta_word_icon.png',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //Text field for Email Field
              TextFieldInput(
                textEditingController: _email,
                hintText: 'Enter Your Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              //Text field for Password Field
              TextFieldInput(
                textEditingController: _password,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.name,
                ispassword: true,
              ),
              //Login Button
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: logInUser,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Log in'),
                ),
              ),
              const Spacer(),
              //Going To SignUp Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BottomMessage(
                    text: 'Don\'t have accout? ',
                    callback: () {},
                  ),
                  BottomMessage(
                    text: 'Sign Up',
                    fontWeight: FontWeight.bold,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
