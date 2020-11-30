import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            child: Column(

            ),
          ),
        ],
      ),
    );
  }
}
