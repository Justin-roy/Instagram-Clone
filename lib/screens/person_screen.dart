import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/profile_screen/post_follower_following_section.dart';
import 'package:instagram_clone/screens/profile_screen/profile_section.dart';
import 'package:instagram_clone/screens/profile_screen/recent_post_section.dart';
import 'package:instagram_clone/screens/profile_screen/tagged_section.dart';

class PersonScreen extends StatefulWidget {
  final String uid;
  const PersonScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  Map userData = {};
  bool _isLoading = true;
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
    // Getting Users Details
    DocumentSnapshot postUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    userData = (postUser.data() as Map<String, dynamic>);
    // Getting User Post/Follower/Following Length
    var posts = await FirebaseFirestore.instance
        .collection('post')
        .where('uid', isEqualTo: _currentUserId)
        .get();

    postLen = posts.docs.length;
    followers = (postUser.data()! as Map<String, dynamic>)['followers'].length;
    following = (postUser.data()! as Map<String, dynamic>)['following'].length;
    //Checking User is Follow or not
    isFollowing = (postUser.data()! as Map<String, dynamic>)['followers']
        .contains(_currentUserId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Decoration _customDecoration = BoxDecoration(
      border: Border.symmetric(
        horizontal: BorderSide(color: Colors.grey),
      ),
    );
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  //Profile Image and name
                  ProfileSection(
                    customDecoration: _customDecoration,
                    userData: userData,
                    uid: widget.uid,
                    isFollowOrNot: isFollowing,
                  ),
                  //Post Follower Following section
                  PostFollowerFollowingSection(
                    customDecoration: _customDecoration,
                    postLength: postLen,
                    followerLength: followers,
                    followingLength: following,
                  ),
                  // tag buttons
                  const TaggedSection(),
                  // Getting all recent posts
                  RecentPostSection(
                    uid: widget.uid,
                  ),
                ],
              ),
            ),
          );
  }
}
