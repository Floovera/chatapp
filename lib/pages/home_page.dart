import 'package:demo/helper/helper_function.dart';
import 'package:demo/pages/profile_page.dart';
import 'package:demo/pages/search_page.dart';
import 'package:demo/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName ="";
  String email="";
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async{
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreenReplace(context, const SearchPage());
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Groups",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
          Icon(
          Icons.account_circle,
          size: 150,
          color: Colors.grey[700],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          userName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          height: 2,
        ),
        ListTile(
              onTap: () {},
              selected: true,
              selectedColor: Theme.of(context).primaryColor,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
        ListTile(
          onTap: () {
            nextScreenReplace(context,ProfilePage(
              userName: userName,
              email: email,));
          },
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const Icon(Icons.group),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () async {
            showDialog(
              barrierDismissible: false,
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await authService.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                                  (route) => false);
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
              ); });
          },
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: const Icon(Icons.exit_to_app),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.black),
          ),
        ),
          ],
        )
      ),
    );
  }
}
