// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Task {
  String id;
  String name;
  String userId;
  int status;
  int type;
  // double order;
  String projectId;
  String sprintId;
  Task? parentTask;
  int startDate;
  int deadline;
  int estimatePoints;
  int priority;
  String description;
  String parentTaskId;
  List<TaskAssignments> taskAssignments;
  Task({
    required this.id,
    required this.name,
    required this.userId,
    required this.status,
    required this.type,
    // required this.order,
    required this.projectId,
    required this.sprintId,
    required this.startDate,
    required this.deadline,
    required this.estimatePoints,
    required this.priority,
    required this.description,
    required this.taskAssignments,
    required this.parentTask,
    required this.parentTaskId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'status': status,
      'type': type,
      // 'order': order,
      'projectId': projectId,
      'sprintId': sprintId,
      'startDate': startDate,
      'deadline': deadline,
      'estimatePoints': estimatePoints,
      'priority': priority,
      'description': description,
      'taskAssignments': taskAssignments.map((x) => x.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      userId: map['userId'] ?? "",
      status: map['status'] ?? -1,
      type: map['type'] ?? -1,
      // order: map['order'] ?? 0,
      projectId: map['projectId'] ?? "",
      sprintId: map['sprintId'] ?? "",
      startDate: map['startDate'] ?? -1,
      deadline: map['deadline'] ?? -1,
      estimatePoints: map['estimatePoints'] ?? -1,
      priority: map['priority'] ?? -1,
      description: map['description'] ?? "",
      parentTask:
          map['parentTask'] != null ? Task.fromMap(map['parentTask']) : null,
      taskAssignments: map['taskAssignments'] != null
          ? (map['taskAssignments'] as List)
              .map(
                (x) => TaskAssignments.fromMap(x as Map<String, dynamic>),
              )
              .toList()
          : [],

      parentTaskId: map['parentTaskId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, name: $name, userId: $userId, status: $status, type: $type, order:, projectId: $projectId, sprintId: $sprintId, startDate: $startDate, deadline: $deadline, estimatePoints: $estimatePoints, priority: $priority, description: $description, taskAssignments: $taskAssignments)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.status == status &&
        other.type == type &&
        // other.order == order &&
        other.projectId == projectId &&
        other.sprintId == sprintId &&
        other.startDate == startDate &&
        other.deadline == deadline &&
        other.estimatePoints == estimatePoints &&
        other.priority == priority &&
        other.description == description &&
        listEquals(other.taskAssignments, taskAssignments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        type.hashCode ^
        // order.hashCode ^
        projectId.hashCode ^
        sprintId.hashCode ^
        startDate.hashCode ^
        deadline.hashCode ^
        estimatePoints.hashCode ^
        priority.hashCode ^
        description.hashCode ^
        taskAssignments.hashCode;
  }
}

class TaskAssignments {
  String userId;
  int role;
  TaskAssignments({
    required this.userId,
    required this.role,
  });

  TaskAssignments copyWith({
    String? userId,
    int? role,
  }) {
    return TaskAssignments(
      userId: userId ?? this.userId,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'role': role,
    };
  }

  factory TaskAssignments.fromMap(Map<String, dynamic> map) {
    return TaskAssignments(
      userId: map['userId'] as String,
      role: map['role'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskAssignments.fromJson(String source) =>
      TaskAssignments.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskAssignments(userId: $userId, role: $role)';

  @override
  bool operator ==(covariant TaskAssignments other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.role == role;
  }

  @override
  int get hashCode => userId.hashCode ^ role.hashCode;
}

class SubTasks {
  String id;
  String name;
  String userId;
  String parentTaskId;
  String projectId;
  String sprintId;
  List<TaskAssignments> taskAssignments;
  SubTasks({
    required this.id,
    required this.name,
    required this.userId,
    required this.parentTaskId,
    required this.projectId,
    required this.sprintId,
    required this.taskAssignments,
  });

  SubTasks copyWith({
    String? id,
    String? name,
    String? userId,
    String? parentTaskId,
    String? projectId,
    String? sprintId,
    List<TaskAssignments>? taskAssignments,
  }) {
    return SubTasks(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      parentTaskId: parentTaskId ?? this.parentTaskId,
      projectId: projectId ?? this.projectId,
      sprintId: sprintId ?? this.sprintId,
      taskAssignments: taskAssignments ?? this.taskAssignments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'parentTaskId': parentTaskId,
      'projectId': projectId,
      'sprintId': sprintId,
      'taskAssignments': taskAssignments.map((x) => x.toMap()).toList(),
    };
  }

  factory SubTasks.fromMap(Map<String, dynamic> map) {
    return SubTasks(
      id: map['_id'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      parentTaskId: map['parentTaskId'] as String,
      projectId: map['projectId'] as String,
      sprintId: map['sprintId'] as String,
      taskAssignments: (map['taskAssignments'] as List)
          .map(
            (x) => TaskAssignments.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTasks.fromJson(String source) =>
      SubTasks.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubTasks(id: $id, name: $name, userId: $userId, parentTaskId: $parentTaskId, projectId: $projectId, sprintId: $sprintId, taskAssignments: $taskAssignments)';
  }

  @override
  bool operator ==(covariant SubTasks other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.userId == userId &&
        other.parentTaskId == parentTaskId &&
        other.projectId == projectId &&
        other.sprintId == sprintId &&
        listEquals(other.taskAssignments, taskAssignments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        userId.hashCode ^
        parentTaskId.hashCode ^
        projectId.hashCode ^
        sprintId.hashCode ^
        taskAssignments.hashCode;
  }
}
