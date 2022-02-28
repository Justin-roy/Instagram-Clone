import 'package:cloud_firestore/cloud_firestore.dart';

class CustomPost {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profileImg;
  final List likes;
  const CustomPost({
    required this.username,
    required this.uid,
    required this.postUrl,
    required this.description,
    required this.postId,
    required this.profileImg,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'postUrl': postUrl,
        'description': description,
        'postId': postId,
        'profileImg': profileImg,
        'datePublished': datePublished,
        'likes': likes,
      };

  static CustomPost fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CustomPost(
      username: snapshot['username'],
      uid: snapshot['uid'],
      postUrl: snapshot['postUrl'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      profileImg: snapshot['profileImg'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    );
  }
}
