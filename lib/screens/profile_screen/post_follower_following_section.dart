import 'package:flutter/material.dart';
import 'package:instagram_clone/Widgets/post_follower_following.dart';

class PostFollowerFollowingSection extends StatelessWidget {
  final int postLength;
  final int followingLength;
  final int followerLength;
  const PostFollowerFollowingSection({
    Key? key,
    required Decoration customDecoration,
    required this.postLength,
    required this.followerLength,
    required this.followingLength,
  })  : _customDecoration = customDecoration,
        super(key: key);

  final Decoration _customDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: _customDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PostFollowerFollowing(
            value: 'post',
            valueCount: postLength,
          ),
          PostFollowerFollowing(
            value: 'followers',
            valueCount: followerLength,
          ),
          PostFollowerFollowing(
            value: 'following',
            valueCount: followingLength,
          ),
        ],
      ),
    );
  }
}
