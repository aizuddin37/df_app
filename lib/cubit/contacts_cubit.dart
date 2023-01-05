import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/user.dart';
import 'app_state.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  late final List<User>? user;

  ContactsCubit({this.user})
      : super(ContactsState(isLoading: false, isInitialize: false, user: [])) {
    init();
  }

  init() {
    _getData();
    return Future.value();
  }

  Future<List<User>?> _getData() async {
    emit(state.copyWith(isLoading: true));
    List<User>? list;

    try {
      var uri = Uri.parse('https://reqres.in/api/users/');

      var response = await http.get(uri);
      print("response:" + "${response.statusCode}");

      final respBody = json.decode(response.body);

      print(respBody);

      // parse only for data part
      if (response.statusCode == 200) {
        List<dynamic> data = respBody["data"];
        print(data);

        list = List<User>.from(data.map((x) => User.fromJson(x)));
        print(list);

        emit(state.copyWith(user: list, isLoading: false));
      }
      emit(state.copyWith(isInitialize: true));
    } catch (error) {
      print(error);
    }
  }

  Future onremoveUser(int? id) async {
    var deleteUrl = Uri.parse("https://reqres.in/api/users/$id");
    print("respons: " + deleteUrl.toString());
    var response = await http.delete(deleteUrl);
    print("respons: " + response.toString());

    if (response.statusCode == 200) {
      print("Deleted");
    } else {
      throw "Sorry! Unable to delete this post.";
    }
  }

  void refresh() {
    emit(state.copyWith(isInitialize: false, isLoading: true));

    init();
  }

  Future onaddUser() async {
    var AddUrl = Uri.parse("https://reqres.in/api/users/");
    var response = await http.post(AddUrl);

    if (response.statusCode == 200) {
      print("Deleted");
    } else {
      throw "Sorry! Unable to delete this post.";
    }
  }
}
