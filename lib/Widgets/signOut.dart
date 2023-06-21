import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

alertSignOutBox(BuildContext context) {
  return AlertDialog(
    title: const Text('Are you sure you want to logout?'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      //
      ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text('Log Out'),
      )
    ],
  );
}
