import 'package:flutter/material.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/screens/profile_screen/post_follower_following_section.dart';
import 'package:instagram_clone/screens/profile_screen/profile_section.dart';
import 'package:instagram_clone/screens/profile_screen/recent_post_section.dart';
import 'package:instagram_clone/screens/profile_screen/tagged_section.dart';
import 'package:provider/provider.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    CustomUser user = Provider.of<UserProvider>(context).getUser;
    const Decoration _customDecoration = BoxDecoration(
      border: Border.symmetric(
        horizontal: BorderSide(color: Colors.grey),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Profile Image and name
            ProfileSection(
              customDecoration: _customDecoration,
              user: user,
            ),
            //Post Follower Following section
            const PostFollowerFollowingSection(
              customDecoration: _customDecoration,
            ),
            // tag buttons
            const TaggedSection(),
            // Getting all recent posts
            const RecentPostSection(),
          ],
        ),
      ),
    );
  }
}
