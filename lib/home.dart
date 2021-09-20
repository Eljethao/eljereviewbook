import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eljereviewbook/model/user_model.dart';
import 'package:eljereviewbook/myservice.dart';
import 'package:eljereviewbook/register.dart';
import 'package:eljereviewbook/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String user, password;

  @override
    void initState() {
      super.initState();
      checkPreference();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elje Review Book'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [Colors.white, Colors.green],
          radius: 1,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showLogo(),
                SizedBox(height: 40),
                showText(),
                SizedBox(height: 15),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> checkPreference()async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
    String idString = preferences.getString('User_ID');

    if(idString != null && idString.isNotEmpty){
      MaterialPageRoute route = MaterialPageRoute(builder: (context)=> MyService());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
    } catch (e) {
    }
  }

  Container showLogo() {
    return Container(
      width: 120,
      height: 120,
      child: Image(
        image: AssetImage('images/locksmith.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showText() {
    return Column(
      // width: MediaQuery.of(context).size.width * 0.6,
      children: [
        nameText(),
        SizedBox(height: 10),
        passwordText(),
      ],
    );
  }

  Widget nameText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 45,
      child: TextField(
        onChanged: (value)=> user = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: 'Username',
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: 45,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          labelText: 'Password',
        ),
        obscureText: true,
      ),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        signInButton(),
        signUpButton(),
      ],
    );
  }

  Widget signInButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onPressed: () {
        if(user == null || user.isEmpty || password == null || password.isEmpty){
          normalDialog(context, 'ກະລຸນາປ້ອນ user ແລະ password ໃຫ້ຄົບກ່ອນ');
        }else{
            checkAuthen();
        }
      },
      icon: Icon(Icons.login),
      label: Text('Sign In'),
    );
  }

  Future<Null> checkAuthen()async{
    String url = 'http://192.168.245.2/eljereviewbook/getUserWhereUser.php?isAdd=true&user_name=$user';
    try {
     Response response = await Dio().get(url);
    //print('res = $response');

    var result = json.decode(response.data);
    print('result = $result');
    for(var map in result){
      UserModel userModel = UserModel.fromJson(map);
      if(password == userModel.password){
        routeToService(MyService(), userModel);
      }
      else{
        normalDialog(context, 'User ຫຼື ລະຫັດຜ່ານບໍຖືກຕ້ອງ ກະລຸນາລອງໃໝ່');
      }
    }
    } catch (e) {
    }
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('User_ID', userModel.id);
    preferences.setString('user_name', userModel.user);

    MaterialPageRoute route = MaterialPageRoute(builder: (context)=> MyService());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }


  Widget signUpButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(builder: (context)=> Register());
        Navigator.push(context, route);
      },
      icon: Icon(Icons.app_registration),
      label: Text('Sign Up'),
    );
  }
}
