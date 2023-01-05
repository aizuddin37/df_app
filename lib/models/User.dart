import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class User extends Equatable {
  int? id;
  String? email;
  String? first_name;
  String? last_name;
  String avatar = " ";

  User(
      {this.id,
      this.email,
      this.first_name,
      this.last_name,
      required this.avatar});

  @override
  toString() => 'id: $id'
      'email: $email'
      'first_name: $first_name'
      'last_name: $last_name'
      'avatar: $avatar';

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    avatar = json['avatar'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['email'] = this.email.toString();
    data['first_name'] = this.first_name.toString();
    data['last_name'] = this.last_name.toString();
    data['avatar'] = this.avatar.toString();

    return data;
  }

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
      id: data['id'] ?? '',
      email: data['email'] ?? '',
      first_name: data['first_name'] ?? '',
      last_name: data['last_name'] ?? '',
      avatar: data['avatar'] ?? '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, email, first_name, last_name, avatar];
}
