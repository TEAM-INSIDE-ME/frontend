class UserModel {
  final String name;

  UserModel.fromJson(Map<String, dynamic> json) : name = json['name'];
}
