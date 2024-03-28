import 'package:chat/components/custom_alert_dialog.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants/constants.dart';
import 'package:chat/constants/custom_color.dart';
import 'package:chat/exceptions/auth_handler_exception.dart';
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
  final _formRegKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formRegKey,
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
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value){
                    (value == null || value.isEmpty) ? 'L\'email est requis':null;
                    return null;
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
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value){
                    (value == null || value.isEmpty) ? 'Le mot de passe est requis':null;
                    return null;

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
                    color: registerBtnColor,
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
                           setState(() {
                             showSpinning = false;
                           });
                         }

                       } on FirebaseAuthException catch (e) {
                         setState(() {
                           showSpinning = false;
                         });
                         var status = AuthHandlerException.handleAuthException(e);
                         var errorMessage = AuthHandlerException.generateErrorMessage(status);
                         if(context.mounted){
                            showAdaptiveDialog(
                              context: context,
                                builder: (context) {
                                return  CustomAlertDialog(
                                 buttonName: 'OK',
                                  textColor: Colors.red,
                                  message: errorMessage,
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
      ),
    );
  }
}