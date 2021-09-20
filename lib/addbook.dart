import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
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
          child: Column(
            children: [
              booknameText(context),
              authorText(context),
              priceText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Price',
          labelStyle: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
          ),
          suffixIcon: Icon(Icons.price_change_outlined)
        ),
      ),
    );
  }

  Widget authorText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
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
