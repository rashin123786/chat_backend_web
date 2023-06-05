class UserModel {
  String? username;
  String? id;
  UserModel({this.id, this.username});
  factory UserModel.fromjson(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      username: map["username"],
    );
  }
}
