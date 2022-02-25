class CustomUser {
  final String username;
  final String uid;
  final String imageUrl;
  final String email;
  final String bio;
  final List followers;
  final List following;
  const CustomUser({
    required this.username,
    required this.uid,
    required this.imageUrl,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'ImageUrl': imageUrl,
      };
}
