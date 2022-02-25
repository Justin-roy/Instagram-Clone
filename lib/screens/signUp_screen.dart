import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Widgets/bottom_message.dart';
import 'package:instagram_clone/Widgets/text_field_input.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //wait for register
  bool isLoading = false;
  //TextInputFields
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _bio = TextEditingController();
  final _username = TextEditingController();
  //Auth
  AuthMethods authMethods = AuthMethods();

  // Captering Image
  Uint8List? _image;

  //Getting Image From Gallery
  selectImage() async {
    Uint8List _in = await pickImage(ImageSource.gallery);
    setState(() {
      _image = _in;
    });
  }

  //Calling Auth
  signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await authMethods.signUpUser(
      email: _email.text,
      password: _password.text,
      bio: _bio.text,
      username: _username.text,
      file: _image!,
    );

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
    setState(() {
      isLoading = false;
    });
  }

  // Disposing TextfieldController..
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _bio.dispose();
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              //InstaGram Image
              Image.asset(
                'assets/images/insta_word_icon.png',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //Taking Image From Gallery
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/default_icon.png'),
                        ),
                  Positioned(
                    right: 0,
                    bottom: -10,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //Text field for UserName Field
              TextFieldInput(
                textEditingController: _username,
                hintText: 'Enter Your UserName',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
              //Text field for Bio Field
              TextFieldInput(
                textEditingController: _bio,
                hintText: 'Enter Your Bio',
                textInputType: TextInputType.text,
              ),

              //Login Button
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signUpUser,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign Up'),
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
                    callback: () {},
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
