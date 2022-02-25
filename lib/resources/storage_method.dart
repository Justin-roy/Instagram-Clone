import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Adding Image to Firebase Storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //Creating Folder To firebase storage
    // like ProfileName/uid
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // Uploading File..
    UploadTask uploadTask = ref.putData(file);
    //Getting Url From Firebase Storage
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
