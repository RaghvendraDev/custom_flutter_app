import 'dart:convert';

class LoginModel {
  final String r_userId;
  final String r_userPass;
  LoginModel({
    required this.r_userId,
    required this.r_userPass,
  });

  LoginModel copyWith({
    String? r_userId,
    String? r_userPass,
  }) {
    return LoginModel(
      r_userId: r_userId ?? this.r_userId,
      r_userPass: r_userPass ?? this.r_userPass,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'r_userId': r_userId,
      'r_userPass': r_userPass,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      r_userId: map['r_userId'],
      r_userPass: map['r_userPass'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModel(r_userId: $r_userId, r_userPass: $r_userPass)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginModel &&
        other.r_userId == r_userId &&
        other.r_userPass == r_userPass;
  }

  @override
  int get hashCode => r_userId.hashCode ^ r_userPass.hashCode;
}
