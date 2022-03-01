import 'package:flutter/material.dart';

class PostFollowerFollowing extends StatelessWidget {
  final String value;
  final int valueCount;
  const PostFollowerFollowing({
    Key? key,
    required this.value,
    required this.valueCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$valueCount',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
