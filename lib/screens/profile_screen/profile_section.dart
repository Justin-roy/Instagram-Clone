import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/firebase_method.dart';

class ProfileSection extends StatefulWidget {
  final String uid;
  final bool isFollowOrNot;
  const ProfileSection({
    Key? key,
    required Decoration customDecoration,
    required this.userData,
    required this.uid,
    required this.isFollowOrNot,
  })  : _customDecoration = customDecoration,
        super(key: key);

  final Decoration _customDecoration;
  final Map userData;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
      decoration: widget._customDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(widget.userData['ImageUrl']),
              ),
              Text(
                widget.userData['username'],
                style: const TextStyle(fontSize: 32),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 32,
                ),
              ),
            ],
          ),
          const Spacer(),
          FirebaseAuth.instance.currentUser!.uid == widget.uid
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    width: 200,
                    height: 46,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : widget.isFollowOrNot
                  ? InkWell(
                      onTap: () async {
                        FirebaseMethod().followUsers(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          followId: widget.userData['uid'],
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            'Unfollow',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        FirebaseMethod().followUsers(
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          followId: widget.userData['uid'],
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            'Follow',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
          const Spacer(),
        ],
      ),
    );
  }
}
