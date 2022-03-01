import 'package:flutter/material.dart';
import 'package:instagram_clone/models/users.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    Key? key,
    required Decoration customDecoration,
    required this.user,
  })  : _customDecoration = customDecoration,
        super(key: key);

  final Decoration _customDecoration;
  final CustomUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
      decoration: _customDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
              const SizedBox(width: 20),
              Text(
                user.username,
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
