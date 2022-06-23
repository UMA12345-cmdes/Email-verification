import 'dart:developer';

import 'package:email_verification/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController cpasswordcontroller = TextEditingController();

void createAccount() async {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String cPassword = cpasswordcontroller.text.trim();

    if(email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!");
    }
    else if(password != cPassword) {
      log("Passwords do not match!");
    }
    else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
        if(userCredential.user != null) {
          Navigator.pop(context);
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
        title: Text('sign up page'),
      ),
      body: SafeArea(
          child: ListView(
            children: [
               Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
             TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextField(
                    controller: cpasswordcontroller,
                    decoration: InputDecoration(
                      labelText: "Confirm Password"
                    ),
                  ),

                  SizedBox(height: 20,),
                   CupertinoButton(
                    onPressed: () {
                      createAccount();
                    },
                    color: Colors.blue,
                    child: Text("Sign Up"),
                  ),

                  SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => LoginScreen()
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