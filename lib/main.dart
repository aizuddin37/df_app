import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rf_app/cubit/contacts_cubit.dart';
import 'package:rf_app/shared/color-helper.dart';
import 'package:rf_app/shared/loading-controller.dart';
import 'package:rf_app/user_profile.dart';

import 'models/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  final String title = "My Contacts";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  User? userdata;
  int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(child: Text(widget.title)),
        ),
        body: BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
          if (!state.isInitialize || state.isLoading) {
            return Center(
              child: LoadingController(),
            );
          } else {
            if (state.user!.isEmpty) {
              return Center(
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
                          Text("No Contacts available",
                              style: TextStyle(
                                  color: shadePrimaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () {
                  context.read<ContactsCubit>().refresh();
                  return Future.value(true);
                },
                child: ListView.builder(
                    itemCount: state.user!.length,
                    itemBuilder: (context, index) {
                      final level_stage = state.user?.elementAt(index);
                      id = level_stage?.id;
                      String image = "/assets/avatar.png";
                      if (state.user!.isEmpty) {
                        image = image;
                      } else {
                        image = level_stage!.avatar.toString();
                      }

                      return Card(
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              backgroundColor: Colors.white,
                              foregroundColor: lightYellow,
                              icon: Icons.edit,
                              onPressed: (BuildContext context) {},
                            ),
                            SlidableAction(
                              backgroundColor: Colors.white,
                              foregroundColor: binRed,
                              icon: Icons.delete,
                              onPressed: (BuildContext context) {
                                _showDialogs(context, id);
                              },
                            )
                          ]),
                          child: ListTile(
                            leading: Card(
                              shape: CircleBorder(),
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: state.isLoading
                                      ? LoadingController(
                                          size: 15, color: primaryColor)
                                      : CircleAvatar(
                                          radius: 18,
                                          child: ClipOval(
                                            child: Image.network(image,
                                                height: 60.0, width: 60.0),
                                          ),
                                        )),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserProfile(user: userdata)));
                            },
                            title: Text('${level_stage?.first_name} '),
                            subtitle:
                                Text('content: ${level_stage?.last_name}'),
                            trailing: Icon(Icons.message, color: primaryColor),
                          ),
                        ),
                      );
                    }),
              );
            }
          }
        }),

        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

_showDialogs(BuildContext context, id) async {
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
                "Are you sure you want to remove this User?",
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
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
                      context.read<ContactsCubit>().onremoveUser(id);
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0))),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(50, 186, 165, 1))),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                          child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      )),
                    )),
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
                        "No",
                        style: TextStyle(color: Colors.black),
                      )),
                    )),
              ),
            ],
          ),
        );
      });
}
