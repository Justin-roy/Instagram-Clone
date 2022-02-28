import 'package:flutter/material.dart';
import 'package:instagram_clone/Widgets/like_animation.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firebase_method.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isAnimation = false;
  @override
  Widget build(BuildContext context) {
    final CustomUser user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // Header Section
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(widget.snap['profileImg']),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.snap['username'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text(
                      'Report',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      'Unfollow',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const PopupMenuItem(child: Text('Share')),
                ],
              ),
            ],
          ),
          // Post Section
          GestureDetector(
            onDoubleTap: () async {
              await FirebaseMethod().postLike(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                _isAnimation = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: Image(
                    image: NetworkImage(
                      widget.snap['postUrl'],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isAnimation ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 150,
                    ),
                    isAnimation: _isAnimation,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        _isAnimation = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Like And Comment Section
          Row(
            children: [
              LikeAnimation(
                isAnimation: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async {
                    await FirebaseMethod().postLike(
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 30,
                        ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border),
              ),
            ],
          ),
          // Description Section
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.snap['likes'].length} likes',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 8,
              top: 10,
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: primaryColor,
                ),
                children: [
                  TextSpan(
                    text: widget.snap['username'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '  ${widget.snap['description']}',
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View all 300 comments',
                style: const TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                // Using intl package to formate timestamp data
                DateFormat.yMd().format(
                  widget.snap['datePublished'].toDate(),
                ),
                style: const TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
