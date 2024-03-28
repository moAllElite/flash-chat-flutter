import 'dart:io';
import 'package:chat/constants/api_key.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: apiKey,
        appId: "1:600888225066:android:bd22367b3fca2910e20253",
        messagingSenderId: "600888225066",
        projectId:"flash-chat-d77ff"
    )
  ):
  await Firebase.initializeApp();
  runApp( _FlashChat());
}

class _FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id: (context) =>   const WelcomeScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        RegistrationScreen.id:(context) => const RegistrationScreen(),
        ChatScreen.id : (context) =>  const ChatScreen()
      },
    );
  }



}
