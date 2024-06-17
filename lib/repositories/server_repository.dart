import 'dart:convert';
import 'dart:io';
import 'dart:math';
// import 'package:elearning_app_game/utils/ultils.dart';
import 'package:dio/dio.dart';
import 'package:ielts/base/base_repository.dart';
import 'package:ielts/models/project.dart';
import 'package:ielts/models/sprint_point.dart';
import 'package:ielts/models/task.dart';
import 'package:ielts/models/user_detail.dart';
import 'package:ielts/repositories/error_handlers.dart';
import 'package:ielts/repositories/exceptions/app_exception.dart';
import 'package:ielts/utils/client_utils.dart';
import 'package:logger/logger.dart';
import '../index.dart';
import '../models/user.dart';

class ServerRepository extends BaseRepository {
  ServerRepository._getIntance();
  static ServerRepository? _intance;
  factory ServerRepository() {
    _intance ??= ServerRepository._getIntance();
    return _intance!;
  }

  var logger = Logger();
  Future<User?> loginAccount(String account, String password) async {
    User? user;
    String endpoint = "${ApiConfig.apiEndPoint}/auth/login";
    var data = {
      "account": account,
      "password": password,
    };
    var dioCall = dioClient.post(
      endpoint,
      data: data,
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        print("xxx   ${response.data['loginCode']}==== ${response.data}");

        if (response.data['loginCode'] != Configs.SUCCESS) {
          throw AppException(
            message: ClientUltis.convertStatus((response.data['loginCode'])),
          );
        }

        user = User.fromMap(response.data);

        print(user!.toJson());
        return user;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUpAccount({
    required String account,
    required String password,
    required String name,
    required String email,
    required String phone,
    required String province,
  }) async {
    User? user;
    String endPoint = "${ApiConfig.apiEndPoint}/auth/register";
    var body = {
      "account": "$account",
      "password": "$password",
      "name": "$name",
      "email": "$email",
      "phone": "$phone",
    };

    print(body);
    var dioCall = dioClient.post(
      endPoint,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      data: body,
    );
    try {
      return callApiWithErrorParser(dioCall).then((response) {
        if (response.data['data'] != null) {
          user = User.fromMap(response.data['data']['data']);
          user!.loginCode = response.data['data']['loginCode'];
          if (user!.loginCode != Configs.SUCCESS) {
            throw AppException(
              message: ClientUltis.convertStatus(user!.loginCode),
            );
          }
          print(user!.toJson());
          return user;
        } else {
          print("000");
          throw AppException(
            message: response.data['message'] ?? "Some error",
          );
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> loginWithaccessToken(String accessToken) async {
    User? user;
    String endpoint = "${ApiConfig.apiEndPoint}/login-with-accessToken";
    var params = {
      "accessToken": accessToken,
      "token": ApiConfig.TOKEN,
    };
    var dioCall = dioClient.post(
      endpoint,
      queryParameters: params,
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        user = User.fromMap(response.data['data']);
        return user;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SprintPoint>> getSprintPoint(String accessToken) async {
    List<SprintPoint> sprintPoints = [];
    String endpoint = "${ApiConfig.apiEndPoint}/sprint-point";

    var dioCall = dioClient.get(
      endpoint,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        print(response.data);
        sprintPoints =
            (response.data as List).map((e) => SprintPoint.fromMap(e)).toList();
        print("getSprintPoint lenght := ${sprintPoints.length}");
        return sprintPoints;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Project>> getProjects(String accessToken) async {
    List<Project> projects = [];
    String endpoint = "${ApiConfig.apiEndPoint}/user-projects";

    var dioCall = dioClient.get(
      endpoint,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        projects =
            (response.data as List).map((e) => Project.fromMap(e)).toList();
        print("getProjects lenght := ${projects.length}");
        return projects;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getTasks(
    String accessToken, {
    required int from,
    required int to,
    required String userId,
    required String project_ids,
  }) async {
    List<Task> tasks = [];
    String endpoint = "${ApiConfig.apiEndPoint}/tasks/allTask";
    var params = {
      "from": from,
      "to": to,
      "userId": userId,
      "project_ids": project_ids
    };
    var dioCall = dioClient.get(
      endpoint,
      queryParameters: params,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        tasks = (response.data as List).map((e) => Task.fromMap(e)).toList();
        print("getTasks lenght := ${tasks.length}");
        return tasks;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SprintPoint>> getSprint(
      String accessToken, String projectId) async {
    List<SprintPoint> sprintPoints = [];
    String endpoint = "${ApiConfig.apiEndPoint}/sprints";

    var dioCall = dioClient.get(
      endpoint,
      queryParameters: {"projectId": projectId},
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        print(response.data);
        sprintPoints = (response.data['data'] as List)
            .map((e) => SprintPoint.fromMap(e))
            .toList();
        print("getSprint lenght := ${sprintPoints.length}");
        return sprintPoints;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getTasksInProject(
    String accessToken, {
    required String sprintId,
    required String projectId,
  }) async {
    List<Task> tasks = [];
    String endpoint = "${ApiConfig.apiEndPoint}/tasks";
    var params = {
      "sprintId": sprintId,
      "projectId": projectId,
      "sortOrder": "desc",
      "skip": 0,
      "isInBacklog": false,
    };
    var dioCall = dioClient.get(
      endpoint,
      queryParameters: params,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        tasks = (response.data as List).map((e) => Task.fromMap(e)).toList();
        print("getTasks lenght := ${tasks.length}");
        return tasks;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserDetail>> getUserDetails(
    String accessToken, {
    required String projectId,
  }) async {
    List<UserDetail> userDetails = [];
    String endpoint =
        "${ApiConfig.apiEndPoint}/projects/$projectId/members-info";
    var params = {
      "projectId": projectId,
    };
    var dioCall = dioClient.get(
      endpoint,
      // queryParameters: params,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
    try {
      return callApiWithErrorParser(dioCall, loginApi: true).then((response) {
        userDetails = (response.data['data'] as List)
            .map((e) => UserDetail.fromMap(e['userDetails']))
            .toList();
        print("getUserDetails lenght := ${userDetails.length}");
        return userDetails;
      });
    } catch (e) {
      rethrow;
    }
  }
}
