class User {
  String? username;
  String? email;
  String? uid;
  String? profilePic;
  List<dynamic> followers;
  List<dynamic> following;
  String? bio;

  User(
      {required this.username,
      required this.email,
      required this.uid,
      required this.bio,
      required this.profilePic,
      required this.followers,
      required this.following});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'] as String,
        email = json['email'] as String,
        bio = json['bio'] as String,
        uid = json['uid'] as String,
        profilePic = json['profilePic'] as String,
        followers = json['followers'] as List<dynamic>,
        following = json['following'] as List<dynamic>;

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
