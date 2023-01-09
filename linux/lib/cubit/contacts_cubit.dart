import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rf_app/models/User.dart';

import 'app_state.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  late final List<Userdata>? user;
  Userdata? _selecteduser;

  ContactsCubit({this.user})
      : super(ContactsState(isLoading: false, isInitialize: false, user: [])) {
    init();
  }

  init() {
    _getData();
    return Future.value();
  }

  Future<List<Userdata>?> _getData() async {
    emit(state.copyWith(isLoading: true));
    List<Userdata>? list;

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

        list = List<Userdata>.from(data.map((x) => Userdata.fromJson(x)));
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

  Future onaddUser(String firstname, String lastname) async {
    emit(state.copyWith(isLoading: true));
    var AddUrl = Uri.parse(
        "https://reqres.in/api/users?name={$firstname}&firstname={$lastname}");

    var response = await http.post(AddUrl);
    print(response.body);

    if (response.statusCode == 201) {
      print("added");
      emit(state.popUpMessage(isLoading: false));
    } else {
      throw "Sorry! Unable to add this user.";
    }
  }

  Future<List<Userdata>?> getUser(int id) async {
    emit(state.copyWith(isLoading: true));
    List<Userdata>? list;
    bool selected = false;

    try {
      var uri = Uri.parse('https://reqres.in/api/users/$id');

      var response = await http.get(uri);
      print("response:" + "${response.statusCode}");

      final respBody = json.decode(response.body);

      print(respBody);

      // parse only for data part
      if (response.statusCode == 200) {
        List<dynamic> data = respBody["data"];
        print(data);

        list = List<Userdata>.from(data.map((x) => Userdata.fromJson(x)));
        print(list);

        emit(state.copyWith(user: list, isLoading: false));
      }
      emit(state.copyWith(isInitialize: true));
    } catch (error) {
      print(error);
    }
  }

  Future<List<Userdata>?> getUsertodelete(int id) async {
    emit(state.copyWith(isLoading: true));
    List<Userdata>? list;
    bool selected = false;

    try {
      var uri = Uri.parse('https://reqres.in/api/users/$id');

      var response = await http.get(uri);
      print("response:" + "${response.statusCode}");

      final respBody = json.decode(response.body);

      print(respBody);

      // parse only for data part
      if (response.statusCode == 200) {
        emit(state.popUpDialog(isLoading: false));
      }
      emit(state.copyWith(isInitialize: true));
    } catch (error) {
      print(error);
    }
  }

  Future setSelectedUser(String firstname, int id) async {
    emit(state.copyWith(isLoading: true));
    var AddUrl =
        Uri.parse("https://reqres.in/api/users/{$id}?name={$firstname}&job= ");

    var response = await http.put(AddUrl);
    print(response.body);

    if (response.statusCode == 200) {
      print("updated");
      emit(state.popUpMessage(isLoading: false));
    } else {
      throw "Sorry! Unable to add this user.";
    }
  }
}
