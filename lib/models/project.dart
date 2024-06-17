// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Project {
  String id;
  String userId;
  String projectId;
  String createdAt;
  int joinedAt;
  int role;
  String updatedAt;
  String name;
  Project({
    required this.id,
    required this.userId,
    required this.projectId,
    required this.createdAt,
    required this.joinedAt,
    required this.role,
    required this.updatedAt,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'projectId': projectId,
      'createdAt': createdAt,
      'joinedAt': joinedAt,
      'role': role,
      'updatedAt': updatedAt,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['_id'] ?? "",
      userId: map['userId'] ?? "",
      projectId: map['projectId'] ?? "",
      createdAt: map['createdAt'] ?? "",
      joinedAt: map['joinedAt'] ?? -1,
      role: map['role'] ?? -1,
      updatedAt: map['updatedAt'] ?? "",
      name: map['project'] != null ? map['project']['name'] : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Project(id: $id, userId: $userId, projectId: $projectId, createdAt: $createdAt, joinedAt: $joinedAt, role: $role, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Project other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.projectId == projectId &&
        other.createdAt == createdAt &&
        other.joinedAt == joinedAt &&
        other.role == role &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        projectId.hashCode ^
        createdAt.hashCode ^
        joinedAt.hashCode ^
        role.hashCode ^
        updatedAt.hashCode;
  }
}

//  {
//         "_id": "66277434dae2b820f4609715",
//         "userId": "660c2b1ccd6ad58aede0b343",
//         "projectId": "662774340644d72e7b0c95fe",
//         "createdAt": "2024-04-23T08:41:24.199Z",
//         "expCoefficientHistories": [
//             {
//                 "value": 1,
//                 "lastUpdate": 0
//             }
//         ],
//         "joinedAt": 1713861684197,
//         "role": 0,
//         "updatedAt": "2024-04-23T08:41:24.199Z"
//     },