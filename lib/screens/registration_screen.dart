import 'package:chat/components/custom_alert_dialog.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static String id= 'registration_screen';
  @override
  RegistrationScreenState createState() => RegistrationScreenState();

}

class RegistrationScreenState extends State<RegistrationScreen> {
  final  _auth = FirebaseAuth.instance;
  late  String email;
  late  String password;
  bool passwordVisibility = false;
  bool showSpinning = false;
  @override
  void initState() {
    passwordVisibility = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinning,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.lightBlue,
        ),
        child: Padding(
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
                  email = value;
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
                  height: hauteur / 25
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                style: const TextStyle(color: Colors.black),
                obscureText: passwordVisibility,
                decoration: kTextFieldDecoration.copyWith(
                  prefixIcon: const Icon(
                      Icons.lock
                  ),
                  suffixIcon:  IconButton(
                      onPressed: (){
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      icon: Icon(
                          passwordVisibility ? Icons.visibility :  Icons.visibility_off
                      )
                  ),
                ),
              ),
              SizedBox(
                  height: hauteur / 15
              ),
              RoundedButton(
                  title: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () async{
                    setState(() {
                      showSpinning = true;
                    });
                     try {
                       final newUser =  await _auth.createUserWithEmailAndPassword(
                                               email: email,
                                               password: password
                       );
                       if( newUser.user?.getIdToken() != null && context.mounted){
                         Navigator.pushNamed(context, ChatScreen.id);
                       }
                     } on FirebaseAuthException catch (e) {
                       if(e.code =='weak-password' && context.mounted){
                          showAdaptiveDialog(
                            context: context,
                              builder: (context) {
                              return  CustomAlertDialog(
                               buttonName: 'OK',
                                message: 'Le mot de passe doit être au moins  de 6 charactères',
                                context: context,
                                icon: errorIcon,
                                title: 'Erreur',
                              );
                              },
                          );
                       }
                     }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}