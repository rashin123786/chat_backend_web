class UserModel {
  String? username;
  String? id;
  String? email;
  UserModel({this.id, this.username, this.email});
  factory UserModel.fromjson(Map<String, dynamic> map) {
    return UserModel(
      id: map["userId"],
      username: map["username"],
      email: map['email'],
    );
  }
}
