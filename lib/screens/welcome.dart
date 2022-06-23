import 'package:flutter/material.dart';
class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('welcome')),
      ),
      body: SafeArea(child: Center(
        child: Container(
          child: Text('you are successfully login'),
        ),
      )),
    );
  }
}