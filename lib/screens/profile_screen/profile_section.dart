import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/utils.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    Key? key,
    required Decoration customDecoration,
    required this.uid,
  })  : _customDecoration = customDecoration,
        super(key: key);

  final Decoration _customDecoration;
  final uid;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  Map userData = {};
  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  _getUserDetails() async {
    try {
      DocumentSnapshot postUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      setState(() {
        userData = (postUser.data() as Map<String, dynamic>);
      });
    } on FirebaseException catch (err) {
      showSnackBar(err.message.toString(), context);
    }
  }

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(userData['ImageUrl']),
              ),
              Text(
                userData['username'],
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
          Container(
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
        ],
      ),
    );
  }
}
