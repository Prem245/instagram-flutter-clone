class User {
  String username;
  String email;
  String uid;
  String profilePic;
  List<String> followers;
  List<String> following;
  String bio;

  User(
      {required this.username,
      required this.email,
      required this.uid,
      required this.bio,
      required this.profilePic,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'username': username,
        'email': email,
        'bio': bio,
        'uid': uid,
        'profilePic': profilePic,
        'followers': followers,
        'following': following,
      };
}
