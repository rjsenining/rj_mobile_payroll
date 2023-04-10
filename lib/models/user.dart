class User {

  int? id;
  final String name;
  final String email;
  final String password;
  final int role_id;
  String? status;
  String? photo;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role_id,
    this.status,
    this.photo
  });
}