class UserAdminModel {
  final int id;
  final String name;
  final String email;
  final String? password;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserAdminModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAdminModel.fromJson(Map<String, dynamic> json) {
    return UserAdminModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] ?? 0,
      name: json['nama'] ?? '',
      email: json['email'] ?? '',
      password: json['password'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': name,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserAdminModel copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserAdminModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
