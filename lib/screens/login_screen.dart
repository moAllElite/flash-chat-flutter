
import 'package:chat/components/my_snack_bar.dart';
import 'package:chat/components/rounded_button.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id ='login_screen';
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  late String email ;
  late String password;
  bool showSpinning = false;
  @override
  void initState() {
    passwordVisible = true;
    super.initState();
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
          Navigator.pushNamed(context, ChatScreen.id);
          debugPrint('User is signed in!');
          setState(() {
           showSpinning = false;
          });
        }
      });

    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' && context.mounted) {
        // Affichez une boîte de dialogue d'alerte si l'utilisateur n'est pas trouvé.
        ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar(
              backgroundColor: Colors.red,
              message: 'L\'utilisateur avec l\'email fourni est introuvable ',
            )
        );

      } else if (e.code == 'wrong-password' && context.mounted) {
        debugPrint('Mot de passe incorrect pour cet utilisateur.');
        ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar(
              backgroundColor :Colors.red,
              message: 'Mot de passe incorrect pour cet utilisateur.',
            )
        );
      }else{
        debugPrint(e.message);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              MySnackBar(
                  backgroundColor: Colors.red,
                  message:'${e.message}'
              )
          );
        }
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
                height: hauteur / 25,
              ),
              TextField(
                obscureText: passwordVisible,
                onChanged: (value) {
                  password = value;
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
                  onPressed: () async {
                      signIn(email, password, context);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}



