import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:eljereviewbook/utility/my_constant.dart';
import 'package:eljereviewbook/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  File file;
  String bookname, authorname, price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add Book',
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                booknameText(context),
                authorText(context),
                priceText(context),
                SizedBox(height: 10),
                bookImage(),
                SizedBox(height: 10),
                saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'Please choose Image');
          } else if (bookname == null ||
              bookname.isEmpty ||
              authorname == null ||
              authorname.isEmpty ||
              price == null ||
              price.isEmpty) {
            normalDialog(context, 'Please fill your blank');
          } else {
            uploadData();
          }
        },
        child: Text(
          'Save Data',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<Null> uploadData() async {
    String url = '${MyConstant().domain}/eljereviewbook/saveBook.php?';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'book$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(url, data: formData).then((value) async {
        String urlPathImage = '/eljereviewbook/BookImage/$nameFile';
        print('urlPathImage = ${MyConstant().domain}$urlPathImage');

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String idString = preferences.getString('book_id');

        String urlInsert =
            '${MyConstant().domain}/eljereviewbook/addBook.php?isAdd=true&book_name=$bookname&book_author=$authorname&book_price=$price&book_image=$urlPathImage';
        await Dio().get(urlInsert).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Widget bookImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 30,
          ),
        ),
        Container(
          width: 240,
          height: 220,
          child:
              file == null ? Image.asset('images/image.png',fit: BoxFit.cover,) : Image.file(file),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 30,
          ),
        )
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 800,
        maxWidth: 800,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget priceText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        onChanged: (value) => price = value.trim(),
        decoration: InputDecoration(
            labelText: 'Price',
            labelStyle: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
            ),
            suffixIcon: Icon(Icons.price_change_outlined)),
      ),
    );
  }

  Widget authorText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        onChanged: (value) => authorname = value.trim(),
        decoration: InputDecoration(
            labelText: 'Author Name',
            labelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            suffixIcon: Icon(Icons.face_outlined)),
      ),
    );
  }

  Container booknameText(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        onChanged: (value) => bookname = value.trim(),
        decoration: InputDecoration(
            labelText: 'Book Name',
            labelStyle: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
            ),
            suffixIcon: Icon(Icons.book_outlined)),
      ),
    );
  }
}
