import 'package:cloud_firestore/cloud_firestore.dart';

class CustomUser {
  final String username;
  final String uid;
  final String imageUrl;
  final String email;
  final String bio;
  final List followers;
  final List following;
  const CustomUser({
    required this.username,
    required this.uid,
    required this.imageUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'ImageUrl': imageUrl,
      };

  static CustomUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CustomUser(
      username: snapshot['username'],
      uid: snapshot['uid'],
      imageUrl: snapshot['ImageUrl'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
