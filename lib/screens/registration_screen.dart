import 'package:chat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String id= 'registration_screen';
  @override
  RegistrationScreenState createState() => RegistrationScreenState();

}

class RegistrationScreenState extends State<RegistrationScreen> {

  bool passwordVisible = false;
  @override
  void initState() {
     passwordVisible = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              decoration: kTextFieldDecoration.copyWith(
                hintText:'Enter your email',
                prefixIcon: const Icon(
                  Icons.email,
                ),
              ),
            ),
            SizedBox(
                height: hauteur / 25
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              obscureText: passwordVisible,
              decoration: kTextFieldDecoration.copyWith(

                prefixIcon: const Icon(
                    Icons.lock
                ),
                suffixIcon:  IconButton(
                    onPressed: (){
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                        passwordVisible ? Icons.visibility :  Icons.visibility_off
                    )
                ),
              ),
            ),
            SizedBox(
                height: hauteur / 15
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Implement registration functionality.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}