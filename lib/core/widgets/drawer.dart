
import 'package:classbloom/core/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/screen/signin.dart';
import '../../model/user_model.dart';

class CAppDrawer extends StatefulWidget {
  const CAppDrawer ({super.key});

  @override
  State<CAppDrawer> createState() => _CAppDrawerState();
}

class _CAppDrawerState extends State<CAppDrawer> {
  @override
  Widget build(BuildContext context) {

    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Text("Class Bloom",style: Theme.of(context).textTheme.headlineMedium),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              AppsHelper.showAlert("Do you want logout?",context,true,logout);
            },
          ),
        ],
      ),
    );
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    currentUserId='';
    currentUser=null;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage(),), (route) => false,);

  }
}
