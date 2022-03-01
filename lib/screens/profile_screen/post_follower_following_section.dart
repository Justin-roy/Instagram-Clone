import 'package:flutter/material.dart';
import 'package:instagram_clone/Widgets/post_follower_following.dart';

class PostFollowerFollowingSection extends StatelessWidget {
  const PostFollowerFollowingSection({
    Key? key,
    required Decoration customDecoration,
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
        children: const [
          PostFollowerFollowing(
            value: 'post',
            valueCount: 18,
          ),
          PostFollowerFollowing(
            value: 'followers',
            valueCount: 189,
          ),
          PostFollowerFollowing(
            value: 'following',
            valueCount: 218,
          ),
        ],
      ),
    );
  }
}
