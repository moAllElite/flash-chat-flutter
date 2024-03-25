import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp( _FlashChat());

class _FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
       // colorScheme: const ColorScheme.dark().copyWith(primary: Colors.black54),
        hintColor:  Colors.black54,
        primaryColor: Colors.black54,
        textTheme:  TextTheme(
          displayMedium:   theme.textTheme.displayMedium!.copyWith(
            color: Colors.black54,
          ),
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
