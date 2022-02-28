import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //This Config is required for web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA5nm3mbHNzYerT4TdEp9u1YeqkSnUD45o",
        authDomain: "instagram-clone-cf306.firebaseapp.com",
        projectId: "instagram-clone-cf306",
        storageBucket: "instagram-clone-cf306.appspot.com",
        messagingSenderId: "850981342746",
        appId: "1:850981342746:web:9b2040d4338e3848540ba3",
        measurementId: "G-83NFB2603H",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      // This FirebaseAuth.instance.authStateChanges(),
      // To Check Is User Is LogIn Before Or Not
      // If user LogIn Never Back To LoginScreen
      // This All Checking By FirebaseAuth(FirebaseAuth.instance.authStateChanges())
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.active) {
            if (snap.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snap.hasError) {
              return Center(
                child: Text('${snap.error}'),
              );
            }
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
