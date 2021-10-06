import 'dart:convert';

class ProjectsNameModel {
  final int id;
  final String name;
  ProjectsNameModel({
    required this.id,
    required this.name,
  });

  ProjectsNameModel copyWith({
    int? id,
    String? name,
  }) {
    return ProjectsNameModel(
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

  factory ProjectsNameModel.fromMap(Map<String, dynamic> map) {
    return ProjectsNameModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectsNameModel.fromJson(String source) =>
      ProjectsNameModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProjectsNameModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectsNameModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
