import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/person_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  // wait for typing in textfild
  bool _isSearch = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search a user',
          ),
          onFieldSubmitted: (e) {
            setState(() {
              _isSearch = true;
            });
          },
        ),
      ),
      body: _isSearch
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isGreaterThanOrEqualTo: _controller.text)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonScreen(
                              uid: snap.data!.docs[index]['uid'],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(snap.data!.docs[index]['ImageUrl']),
                        ),
                        title: Text(snap.data!.docs[index]['username']),
                      ),
                    );
                  },
                );
              },
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance.collection('post').snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  itemCount: (snap.data! as dynamic).docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: (snap.data! as dynamic).docs[index]['postUrl'],
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
                );
              },
            ),
      floatingActionButton: _isSearch
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _controller.clear();
                setState(() {
                  _isSearch = false;
                });
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.white,
                size: 32,
              ),
            )
          : Container(),
    );
  }
}
