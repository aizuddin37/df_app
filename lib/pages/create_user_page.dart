import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rf_app/cubit/contacts_cubit.dart';
import 'package:rf_app/shared/loading-controller.dart';

import '../models/User.dart';
import '../shared/color-helper.dart';

class CreateUserProfile extends StatefulWidget {
  static String routeName = '/create-user-page';

  const CreateUserProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(child: Text("New User")),
        ),
        body: BlocConsumer<ContactsCubit, ContactsState>(
            builder: (context, state) {
              if (state.user != null) {
                print("current user :" + state.user.toString());
                return Container(
                    child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Card(
                        shape: CircleBorder(),
                        child: SizedBox(
                            height: 90,
                            width: 90,
                            child: state.isLoading
                                ? LoadingController(
                                    size: 15, color: primaryColor)
                                : CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Image.asset(
                                          "lib/assets/avatar.png",
                                          height: 80.0,
                                          width: 80.0),
                                    ),
                                  )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            TextField(
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontWeight: FontWeight.normal),
                              textCapitalization: TextCapitalization.sentences,
                              controller: firstname,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                hintText: "First Name",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              onChanged: (e) {
                                setState(() {
                                  firstname.text = e;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: lastname,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                hintText: "Last Name",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              onChanged: (e) {
                                setState(() {
                                  lastname.text = e;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: email,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23.0),
                                    borderSide: BorderSide(
                                      color: primaryColor,
                                    )),
                                hintText: "Email",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              onChanged: (e) {
                                setState(() {
                                  email.text = e;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => createUser(context),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0))),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(50, 186, 165, 1))),
                          child: Container(
                            width: 150,
                            height: 40,
                            child: Center(
                                child: Text(
                              "Done",
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
            listenWhen: (previous, current) => current is MessageDialogState,
            listener: (context, state) async {
              if (state is MessageDialogState) {
                _showMessage(context);
              }
            }),
      ),
    );
  }

  void createUser(BuildContext context) {
    context.read<ContactsCubit>().onaddUser(firstname.text, lastname.text);
  }
}

_showMessage(BuildContext context) async {
  return showDialog<bool?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          title: Column(
            children: [
              Text(
                "Successfully Created!",
                maxLines: 2,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: primaryColor),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 4,
                color: primaryColor,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 38,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(_).pop(false);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.black),
                      )),
                    )),
              ),
            ],
          ),
        );
      });
}
