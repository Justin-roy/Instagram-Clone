import 'package:flutter/material.dart';

class TaggedSection extends StatelessWidget {
  const TaggedSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.apps_outlined,
              size: 42,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.bookmark_border_outlined,
              size: 42,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.photo_camera_front_outlined,
              size: 42,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
