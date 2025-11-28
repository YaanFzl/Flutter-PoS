class User {
  final String token;
  final String email;
  final String role;

  User({
    required this.token,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'] ?? '',
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? '',
    );
  }
}
