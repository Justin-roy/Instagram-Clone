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

  // For Storing Comments..
  Future<String> postComment({
    required String postId,
    required String text,
    required String uid,
    required String name,
    required String profilePic,
    required List likes,
  }) async {
    String res = 'some error occured';
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('post')
            .doc(postId)
            .collection('comment')
            .doc(commentId)
            .set({
          'profileImg': profilePic,
          'uid': uid,
          'username': name,
          'comment': text,
          'postId': postId,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'likes': likes,
        });
      } else {
        res = 'Text is Empty';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // For Following Users
  Future<void> followUsers(
      {required String uid, required String followId}) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];
      if (following.contains(followId)) {
        await _firestore.collection('users').doc(uid).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
