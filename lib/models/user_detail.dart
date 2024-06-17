// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetail {
  String account;
  String name;
  String avatar;
  String email;
  UserDetail({
    required this.account,
    required this.name,
    required this.avatar,
    required this.email,
  });

  UserDetail copyWith({
    String? account,
    String? name,
    String? avatar,
    String? email,
  }) {
    return UserDetail(
      account: account ?? this.account,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'account': account,
      'name': name,
      'avatar': avatar,
      'email': email,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      account: map['account'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) =>
      UserDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetail(account: $account, name: $name, avatar: $avatar, email: $email)';
  }

  @override
  bool operator ==(covariant UserDetail other) {
    if (identical(this, other)) return true;

    return other.account == account &&
        other.name == name &&
        other.avatar == avatar &&
        other.email == email;
  }

  @override
  int get hashCode {
    return account.hashCode ^ name.hashCode ^ avatar.hashCode ^ email.hashCode;
  }
}
