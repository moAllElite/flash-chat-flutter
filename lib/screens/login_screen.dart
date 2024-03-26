import 'package:chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id ='login_screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              keyboardType: TextInputType.emailAddress,
              decoration: kTextFieldDecoration.copyWith(
                hintText:'Enter your email',
                prefixIcon: const Icon(
                  Icons.email,
                ),
              ),
            ),
            SizedBox(
              height: hauteur / 25,
            ),
            TextField(
              obscureText: passwordVisible,
              onChanged: (value) {
                //Do something with the user input.
              },
              style: const TextStyle(color: Colors.black),
              decoration:kTextFieldDecoration.copyWith(
                prefixIcon: const Icon(
                    Icons.lock
                ),
                suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        passwordVisible = ! passwordVisible;
                      });
                    },
                    icon: Icon(
                        passwordVisible ? Icons.visibility :  Icons.visibility_off
                    )
                ),
              ),
            ),
            SizedBox(
              height:  hauteur / 15,
            ),
            RoundedButton(
                title: 'Log in',
                color: Colors.lightBlueAccent,
                onPressed: (){

                })
          ],
        ),
      ),
    );
  }
}