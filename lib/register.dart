import 'package:dio/dio.dart';
import 'package:eljereviewbook/utility/normal_dialog.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, password;
  final nameControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              nameText(),
              SizedBox(height: 30),
              passwordText(),
              SizedBox(height: 50),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        controller: nameControl,
        onChanged: (value) => username = value.trim(),
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: 'Username',
          helperText: 'Input your name here',
          icon: Icon(Icons.face, color: Colors.teal),
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextFormField(
        controller: passwordControl,
        onChanged: (value) => password = value.trim(),
        style: TextStyle(fontSize: 18),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          helperText: 'Input your password here',
          icon: Icon(Icons.lock, color: Colors.teal),
        ),
      ),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        primary: Colors.green,
      ),
      onPressed: () {
        if (username == null ||
            username.isEmpty ||
            password == null ||
            password.isEmpty) {
            normalDialog(context, 'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ');
        }else{
          uploadData();
        }
      },
      child: Text('Save Data'),
    );
  }

  Future<Null> uploadData() async{
    String url = 'http://192.168.245.2/eljereviewbook/addUser.php?isAdd=true&user_name=$username&user_password=$password';
    await Dio().get(url).then((value) {
      normalDialog(context, 'ບັນທຶກສຳເລັດ'); 
      //Navigator.pop(context);
      nameControl.clear();
      passwordControl.clear(); 
    });
  }
}
