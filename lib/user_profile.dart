import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rf_app/cubit/contacts_cubit.dart';
import 'package:rf_app/shared/loading-controller.dart';

import 'models/User.dart';
import 'shared/color-helper.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, User? user}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(child: Text("Profile")),
        ),
        body: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            return Container(
                child: Center(
              child: Column(
                children: [
                  Card(
                    shape: CircleBorder(),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: state.isLoading
                            ? LoadingController(size: 15, color: primaryColor)
                            : CircleAvatar(
                                radius: 18,
                                child: ClipOval(
                                  child: Image.asset("/assets/avatar.png",
                                      height: 60.0, width: 60.0),
                                ),
                              )),
                  ),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
