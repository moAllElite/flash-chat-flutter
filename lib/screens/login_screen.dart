import 'package:chat/exceptions/auth_handler_exception.dart';
import 'package:chat/components/my_snack_bar.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants/custom_color.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants/constants.dart';

class LoginScreen extends StatefulWidget {
  static String id ='login_screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool passwordVisible = false;
  late String email ;
  late String password;
  bool showSpinning = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    passwordVisible = true;
    isEmailEmpty = false;
    isEmailEmpty = false;
    super.initState();
  }
  Color iconColor(bool errorFound){
    return errorFound == true ? Colors.redAccent.shade700: Colors.grey.shade800;
  }
  void signIn(String email, String password, BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;//.instanceFor(app: Firebase.app());

       await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      auth.authStateChanges().listen((User ? user) {
        if(user == null){
          debugPrint('l\'utilisateur est déconnecté');
        }else{
          // Si l'authentification est réussie, naviguez vers une nouvelle page.
          setState(() {
            showSpinning = false;
          });
          Navigator.pushNamed(context, ChatScreen.id);
          debugPrint('User is signed in!');
        }
      });

    }on FirebaseAuthException catch (e) {
      setState(() {
        showSpinning = false;
      });
      var status = AuthHandlerException.handleAuthException(e);
      var errorMessage  = AuthHandlerException.generateErrorMessage(status);
      if (context.mounted) {
        // Affichez une snack bar d'alerte en cas d'erreur.
        ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              backgroundColor: Colors.red,
              message: errorMessage,
            )
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinning,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.lightBlue,
        ),
        child: Form(
          key: _formKey,
          child: Padding(
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
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: ( value){
                    if( value == null || value.isEmpty){
                      setState(() {
                        isEmailEmpty = true;
                      });
                      return 'Le champs email est requis!!';
                    }else{
                      setState(() {
                        isEmailEmpty = false;
                      });
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText:'Enter your email',
                    prefixIcon:  Icon(
                      Icons.email,
                      color: iconColor(isEmailEmpty),
                    ),
                  ),
                ),
                SizedBox(
                  height: hauteur / 25,
                ),
                TextFormField(
                  obscureText: passwordVisible,
                  onChanged: (value) {
                    password = value;
                  },
                  // The validator receives the text that the user has entered
                  validator: ( value){
                    if( value == null || value.isEmpty){
                      setState(() {
                        isPasswordEmpty = true;
                      });
                      return 'Le champs mot de passe est requis!!';
                    }else{
                      setState(() {
                        isPasswordEmpty = false;
                      });
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration:kTextFieldDecoration.copyWith(
                    prefixIcon:  Icon(
                        Icons.lock,
                      color:iconColor(isPasswordEmpty),
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
                    color: loginBtnColor,
                    onPressed: () async {

                      if(_formKey.currentState!.validate()){
                        setState(() {
                          showSpinning = true;
                        });
                        signIn(email, password, context);
                      }else{
                        mySnackBar(
                            backgroundColor: Colors.red,
                            message: 'Tous les champs sont obligatoires'
                        );

                        print( "as $isPasswordEmpty $isEmailEmpty");
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



