import 'dart:developer';

import 'package:email_verification/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();


 void login() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();

    if(email == "" || password == "") {
      log("Please fill all the fields!");
    }
    else {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, 
          password: password);
        if(userCredential.user != null) {

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Welcome()
          ));
          
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login page'),
      ),
      body:  SafeArea(
          child: ListView(
            children: [
               Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
             TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: "Email Address"
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),


                
                  SizedBox(height: 20,),
                   CupertinoButton(
                    onPressed: () {
                      login();
                    },
                    color: Colors.blue,
                    child: Text("Log In"),
                  ),

                  SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => SignupScreen()
                      ));
                    },
                    child: Text("Create an Account"),
                  ),

                ],
          ),
        
        ),
            ]
      ),
      ),
    );
  }
}