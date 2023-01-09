import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rf_app/cubit/contacts_cubit.dart';
import 'package:rf_app/pages/create_user_page.dart';
import 'package:rf_app/pages/user_input_page.dart';
import 'package:rf_app/shared/color-helper.dart';
import 'package:rf_app/shared/loading-controller.dart';
import 'package:rf_app/pages/user_profile.dart';
import 'models/User.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
        '/profile-page': (context) => UserProfile(user: user),
      },
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

  late Userdata userdata;
  late int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit()..init(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Center(child: Text(widget.title)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<ContactsCubit, ContactsState>(
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    height: 25,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        color: Colors.grey),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: TabBar(
                                        indicator: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        labelStyle: TextStyle(fontSize: 8),
                                        tabs: [
                                          Tab(
                                            text: 'All',
                                          ),
                                          Tab(
                                            text: 'favorites',
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                ListView.builder(
                                    itemCount: state.user!.length,
                                    itemBuilder: (context, index) {
                                      final user_stage =
                                          state.user?.elementAt(index);

                                      id = user_stage?.id ?? 0;
                                      String image = "/assets/avatar.png";
                                      if (state.user!.isEmpty) {
                                        image = image;
                                      } else {
                                        image = user_stage!.avatar.toString();
                                      }

                                      return Card(
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                              motion: ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: lightYellow,
                                                  icon: Icons.edit,
                                                  onPressed:
                                                      (BuildContext context) {
                                                    setState(() {
                                                      userdata = state.user!
                                                          .elementAt(index);
                                                    });

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UpdateUserProfile(
                                                                  user:
                                                                      userdata,
                                                                )));
                                                  },
                                                ),
                                                SlidableAction(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: binRed,
                                                  icon: Icons.delete,
                                                  onPressed:
                                                      (BuildContext context) {
                                                    deleteUser(context, id);
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
                                                          size: 15,
                                                          color: primaryColor)
                                                      : CircleAvatar(
                                                          radius: 18,
                                                          child: ClipOval(
                                                            child:
                                                                Image.network(
                                                                    image,
                                                                    height:
                                                                        60.0,
                                                                    width:
                                                                        60.0),
                                                          ),
                                                        )),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                userdata = state.user!
                                                    .elementAt(index);
                                              });

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfile(
                                                            user: userdata,
                                                          )));
                                            },
                                            title: Text(
                                                '${user_stage?.first_name} ' +
                                                    ' ${user_stage?.last_name}'),
                                            subtitle:
                                                Text(' ${user_stage?.email}'),
                                            trailing: Icon(Icons.message,
                                                color: primaryColor),
                                          ),
                                        ),
                                      );
                                    }),
                                Container(
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
                                            Text(
                                                "No Favorite Contacts  available",
                                                style: TextStyle(
                                                    color: shadePrimaryColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                              ]),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                listenWhen: (previous, current) =>
                    current is ConfirmationDialogState,
                listener: (context, state) async {
                  if (state is ConfirmationDialogState) {
                    _showDialogs(context, id);
                  }
                }),
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateUserProfile()));
            },
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}

deleteUser(BuildContext context, int id) {
  context.read<ContactsCubit>().getUsertodelete(id);
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
                      Navigator.of(_).pop(false);
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
