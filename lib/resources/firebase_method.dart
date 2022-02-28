import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImg,
  ) async {
    String res = 'some error occured';
    try {
      // Uploading and Downloading Img from firebase
      String photoUrl =
          await StorageMethods().uploadImageToStorage('post', file, true);
      //getting unique id from uuid package
      String postId = const Uuid().v1();
      CustomPost post = CustomPost(
        username: username,
        uid: uid,
        postUrl: photoUrl,
        description: description,
        postId: postId,
        profileImg: profileImg,
        datePublished: DateTime.now(),
        likes: [],
      );
      // Now All Data Uploading to firebase
      _firestore.collection('post').doc(postId).set(
            post.toJson(),
          );
      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Getting Count of Likes
  Future<void> postLike(String postId, String uid, List likes) async {
    try {
      // check if post is already like
      if (likes.contains(uid)) {
        await _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      }
      // if not like the post
      else {
        await _firestore.collection('post').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
