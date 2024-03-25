import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp( _FlashChat());

class _FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black54,
        textTheme: const TextTheme(
          displayMedium:  TextStyle(color: Colors.black54),
        ),
      ),
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
