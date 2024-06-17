// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SprintPoint {
  String id;
  String name;
  String description;
  int startDate;
  int endDate;
  int status;
  String projectId;
  bool isBacklog;
  String createdAt;
  String updatedAt;
  int priority;
  SprintPoint({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.projectId,
    required this.isBacklog,
    required this.createdAt,
    required this.updatedAt,
    required this.priority,
  });

  SprintPoint copyWith({
    String? id,
    String? name,
    String? description,
    int? startDate,
    int? endDate,
    int? status,
    String? projectId,
    bool? isBacklog,
    String? createdAt,
    String? updatedAt,
    int? priority,
  }) {
    return SprintPoint(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      projectId: projectId ?? this.projectId,
      isBacklog: isBacklog ?? this.isBacklog,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'projectId': projectId,
      'isBacklog': isBacklog,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'priority': priority,
    };
  }

  factory SprintPoint.fromMap(Map<String, dynamic> map) {
    return SprintPoint(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      startDate: map['startDate'] ?? -1,
      endDate: map['endDate'] ?? -1,
      status: map['status'] ?? -1,
      projectId: map['projectId'] ?? "",
      isBacklog: map['isBacklog'] ?? false,
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
      priority: map['priority'] ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory SprintPoint.fromJson(String source) =>
      SprintPoint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SprintPoint(id: $id, name: $name, description: $description, startDate: $startDate, endDate: $endDate, status: $status, projectId: $projectId, isBacklog: $isBacklog, createdAt: $createdAt, updatedAt: $updatedAt, priority: $priority)';
  }

  @override
  bool operator ==(covariant SprintPoint other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.status == status &&
        other.projectId == projectId &&
        other.isBacklog == isBacklog &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        status.hashCode ^
        projectId.hashCode ^
        isBacklog.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        priority.hashCode;
  }
}

//  {
//             "_id": "664065e2c7b8fa0da046dce3",
//             "name": "wise 1",
//             "description": "<p>wise 1</p>",
//             "startDate": 1714496400000,
//             "endDate": 1717088400000,
//             "status": 0,
//             "projectId": "664065c9c7b8fa0da046dccf",
//             "isBacklog": false,
//             "createdAt": "2024-05-12T06:46:58.930Z",
//             "updatedAt": "2024-05-13T06:42:57.993Z",
//             "priority": 2
//         },