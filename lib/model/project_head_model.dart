import 'dart:convert';

class ProjectHeadModel {
  final int id;
  final String name;
  ProjectHeadModel({
    required this.id,
    required this.name,
  });

  ProjectHeadModel copyWith({
    int? id,
    String? name,
  }) {
    return ProjectHeadModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ProjectHeadModel.fromMap(Map<String, dynamic> map) {
    return ProjectHeadModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectHeadModel.fromJson(String source) =>
      ProjectHeadModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProjectHeadModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectHeadModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
