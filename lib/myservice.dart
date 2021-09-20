import 'package:eljereviewbook/addbook.dart';
import 'package:eljereviewbook/utility/signout_process.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String userName;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: userName == null ? Text('My Service') : Text('$userName login'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          ),
        ],
      ),
      body: Text('This is myhome service'),
    );
  }

  Drawer showDrawer() => Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                showHead(),
                addBook(),
                menuListBook(),
                userInformation(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                signOutApp(),
              ],
            )
          ],
        ),
      );

  Widget addBook() {
    return ListTile(
      leading: Icon(
        Icons.add_box,
        color: Colors.teal,
        size: 35,
      ),
      title: Text('Add Book'),
      subtitle: Text('Add a new book here'),
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context)=> AddBook());
        Navigator.push(context, route);
      },
    );
  }

  Widget menuListBook() {
    return ListTile(
      leading: Icon(Icons.list_alt, color: Colors.teal, size: 35),
      title: Text('List book'),
      subtitle: Text('All your list book'),
      onTap: () {},
    );
  }

  Widget userInformation() {
    return ListTile(
      leading: Icon(Icons.face, color: Colors.teal, size: 35),
      title: Text('User Information'),
      subtitle: Text('This is your information'),
      onTap: () {},
    );
  }

  Widget signOutApp() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        color: Colors.red,
        size: 35,
      ),
      title: Text('Sign Out'),
      subtitle: Text('exit from your account'),
      onTap: () => signOutProcess(context),
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/home.jpg'),
        fit: BoxFit.cover,
      )),
      accountName: Text(
        userName == null ? 'Name Login' : userName,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('user_name');
    });
  }
}
