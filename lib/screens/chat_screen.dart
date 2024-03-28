import 'package:chat/constants/constants.dart';
import 'package:chat/constants/custom_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chat_screen';
  @override
  ChatScreenState createState()  => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  final db = FirebaseFirestore.instance;
  late String textMessage;
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
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }
/*  void getMessages()async{
    final messages = await _firestore.collection('messages').get().then(
            (messages) {
              for(var message in messages.docs){
                debugPrint('${message.data()}');
              }
            });
  }*/
  void signOut() async{
    await FirebaseAuth.instance.signOut();
    if(mounted) Navigator.of(context).pushNamed(LoginScreen.id);
  }

  void messagesStream () async{
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for(var message in snapshot.docs){
        debugPrint('${message.id} => ${message.data()}');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: IconButton(
            onPressed: ()async => signOut(),
            icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close,color: Colors.white,),
              onPressed: () async{
                messagesStream();
                //signOut();
              }),
        ],
        title:  const Text('⚡️Chat',style: TextStyle(color:Colors.white),),
        backgroundColor: loginBtnColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot)  {
                List<Text> messagesWidgets = [];
                if(!snapshot.hasData){
                  return  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    ),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                for (var message in messages){
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final messageWidget = Text(
                    "$messageText from $messageSender",
                  );
                  messagesWidgets.add(messageWidget);
                }

                return Column(
                  children: messagesWidgets,
                );
              },
            ),
            Container(
              decoration: messageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: messageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.

                      _firestore.collection('messages')
                          .add({
                        'text':textMessage,
                        'sender':loggedInUser.email,
                      });

                    },
                    child: Icon(
                      Icons.send,
                      color: loginBtnColor,
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