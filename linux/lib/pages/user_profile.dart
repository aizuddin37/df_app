import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rf_app/cubit/contacts_cubit.dart';
import 'package:rf_app/pages/user_input_page.dart';
import 'package:rf_app/shared/loading-controller.dart';

import '../models/User.dart';
import '../shared/color-helper.dart';

class UserProfile extends StatefulWidget {
  static String routeName = '/profile-page';
  final Userdata user;
  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Userdata userdata;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit()..getUser(widget.user.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(child: Text("Profile")),
        ),
        body: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            if (state.user != null) {
              print("current user :" + state.user.toString());
              return Container(
                  child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        setState(() {
                          userdata = widget.user;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateUserProfile(
                                      user: userdata,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(280, 10, 0, 10),
                        child: Text("Edit",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: primaryColor)),
                      ),
                    ),
                    Card(
                      shape: CircleBorder(),
                      child: SizedBox(
                          height: 90,
                          width: 90,
                          child: state.isLoading
                              ? LoadingController(size: 15, color: primaryColor)
                              : CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primaryColor,
                                  child: ClipOval(
                                    child: state.user!.isNotEmpty
                                        ? Image.network(widget.user.avatar,
                                            height: 80.0, width: 80.0)
                                        : Image.asset("lib/assets/avatar.png",
                                            height: 80.0, width: 80.0),
                                  ),
                                )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                          widget.user.first_name + widget.user.last_name,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal)),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        child: Icon(Icons.email_outlined,
                            color: primaryColor, size: 40),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(widget.user.email,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0))),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(50, 186, 165, 1))),
                        child: Container(
                          width: 150,
                          height: 40,
                          child: Center(
                              child: Text(
                            "Send Email",
                            style: TextStyle(color: Colors.white),
                          )),
                        ))
                  ],
                ),
              ));
            } else {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: Image.asset(
                                'lib/assets/amico.png',
                              ),
                            ),
                            SizedBox(height: 20),
                            Text("User is not available",
                                style: TextStyle(
                                    color: shadePrimaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
