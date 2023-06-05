class UserModel {
  String? username;
  int? id;
  UserModel({this.id, this.username});
  factory UserModel.fromjson(Map<String, dynamic> map) {
    return UserModel(
      id: map["userId"],
      username: map["username"],
    );
  }
}
