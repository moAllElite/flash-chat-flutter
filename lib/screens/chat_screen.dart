import 'package:chat/constants.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chat_screen';
  @override
  ChatScreenState createState()  => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async{
    try {
      final  user =  _auth.currentUser;
      if(user != null){
            loggedInUser = user;
          }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: null,,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async{
                //Implement logout functionality
               final isLogout = await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: messageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: messageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: sendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}