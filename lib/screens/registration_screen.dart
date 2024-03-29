import 'package:chat/components/custom_alert_dialog.dart';
import 'package:chat/components/my_snack_bar.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants/constants.dart';
import 'package:chat/constants/custom_color.dart';
import 'package:chat/exceptions/auth_handler_exception.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
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
  late String email;
  late String password;
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
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
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
                   if (value == null || value.isEmpty) return 'L\'email est requis';
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
                    if ( value == null || value.isEmpty) {
                      return 'Le mot de passe est requis';
                    }
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
                       try {
                         if (_formRegKey.currentState!.validate() ) {
                           final newUser =  await _auth.createUserWithEmailAndPassword(
                                                                            email: email,
                                                                            password: password
                                                    );
                           if( newUser.user?.getIdToken() != null && context.mounted){
                             setState(() {
                               showSpinning = false;
                             });
                             Navigator.pushNamed(context, ChatScreen.id);
                           }
                         }else{
                           ScaffoldMessenger.of(context).showSnackBar(
                               mySnackBar(backgroundColor: Colors.red, message: 'Tous les champs sont obligatoire')
                           );
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
                ),
                const SizedBox(
                  height: 6.0,
                ),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, LoginScreen.id);
                }
                    , child: Text(
                        'Vous avez un compte?',
                      style: TextStyle(
                        color: registerBtnColor,
                        fontSize: 16.0,
                      ),
                    )
                )
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}