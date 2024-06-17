// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int loginCode;
  String accessToken;
  final String refreshToken;
  final String id;
  final String account;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;
  final int userRole;
  final int lastLogin;
  final int birth;
  final String address;
  final int gender;
  final int goalPoint;
  final int expiresIn;
  User({
    required this.loginCode,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.account,
    required this.name,
    required this.email,
    required this.avatar,
    required this.phoneNumber,
    required this.userRole,
    required this.lastLogin,
    required this.birth,
    required this.address,
    required this.gender,
    required this.goalPoint,
    required this.expiresIn,
  });

  User copyWith({
    int? loginCode,
    String? accessToken,
    String? refreshToken,
    String? id,
    String? account,
    String? name,
    String? email,
    String? avatar,
    String? phoneNumber,
    int? userRole,
    int? lastLogin,
    int? birth,
    String? address,
    int? gender,
    int? goalPoint,
    int? expiresIn,
  }) {
    return User(
      loginCode: loginCode ?? this.loginCode,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
      account: account ?? this.account,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userRole: userRole ?? this.userRole,
      lastLogin: lastLogin ?? this.lastLogin,
      birth: birth ?? this.birth,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      goalPoint: goalPoint ?? this.goalPoint,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginCode': loginCode,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      '_id': id,
      'account': account,
      'name': name,
      'email': email,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'userRole': userRole,
      'lastLogin': lastLogin,
      'birth': birth,
      'address': address,
      'gender': gender,
      'goalPoint': goalPoint,
      'expiresIn': expiresIn,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      loginCode: map['loginCode'] ?? 0,
      accessToken: map['accessToken'] ?? "",
      refreshToken: map['refreshToken'] ?? "",
      id: map['_id'] ?? "",
      account: map['account'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      avatar: map['avatar'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      userRole: map['userRole'],
      lastLogin: map['lastLogin'] ?? 0,
      birth: map['birth'] ?? "",
      address: map['address'] ?? "",
      gender: map['gender'] ?? 0,
      goalPoint: map['goalPoint'] ?? 0,
      expiresIn: map['expiresIn'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(loginCode: $loginCode, accessToken: $accessToken, refreshToken: $refreshToken, id: $id, account: $account, name: $name, email: $email, avatar: $avatar, phoneNumber: $phoneNumber, userRole: $userRole, lastLogin: $lastLogin, birth: $birth, address: $address, gender: $gender, goalPoint: $goalPoint, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.loginCode == loginCode &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.id == id &&
        other.account == account &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar &&
        other.phoneNumber == phoneNumber &&
        other.userRole == userRole &&
        other.lastLogin == lastLogin &&
        other.birth == birth &&
        other.address == address &&
        other.gender == gender &&
        other.goalPoint == goalPoint &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return loginCode.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        id.hashCode ^
        account.hashCode ^
        name.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        phoneNumber.hashCode ^
        userRole.hashCode ^
        lastLogin.hashCode ^
        birth.hashCode ^
        address.hashCode ^
        gender.hashCode ^
        goalPoint.hashCode ^
        expiresIn.hashCode;
  }
}

/*
{
    "loginCode": 0,
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MGMyYjFjY2Q2YWQ1OGFlZGUwYjM0MyIsImlhdCI6MTcxNjU2MzcxNiwiZXhwIjoxNzE2NjUwMTE2fQ.N0WYCCLrO81D51pX6zd3deyam18F-J0sm9OqAqM4gOI",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MGMyYjFjY2Q2YWQ1OGFlZGUwYjM0MyIsImlhdCI6MTcxNjU2MzcxNiwiZXhwIjoxNzE3MTY4NTE2fQ.0PubFbZtesaVqiOHriKUal-p5s-cL2jVSvEGkYqPr04",
    "_id": "660c2b1ccd6ad58aede0b343",
    "account": "sondt",
    "password": "48c64fe778711f33f7b0948cb13f42adc9397e1fe047ed200a4ee8f89569f00d",
    "name": "Dang Son",
    "email": "sondt@gmail.com",
    "avatar": "https://yt3.ggpht.com/yti/ANjgQV9B-t1MCn3p616Ebh9RruKC88gATAZiRv496PCDSA=s88-c-k-c0x00ffffff-no-rj",
    "phoneNumber": "",
    "userRole": 1,
    "discordId": "",
    "facebookId": "",
    "googleId": "",
    "status": 1,
    "lastLogin": 1716563716116,
    "birth": 0,
    "address": "",
    "gender": 0,
    "goalPoint": 0,
    "expiresIn": 604800000
}
\*/