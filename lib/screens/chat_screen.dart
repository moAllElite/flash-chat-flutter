import 'package:chat/components/message_bubble.dart';
import 'package:chat/constants/constants.dart';
import 'package:chat/constants/custom_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
final _auth = FirebaseAuth.instance;
late User loggedInUser;
final _firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chat_screen';
  @override
  ChatScreenState createState()  => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  late String textMessage;
  final messageTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getTimeOfDay();
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
  void signOut() async{
    await FirebaseAuth.instance.signOut();
    if(mounted) Navigator.of(context).pushNamed(LoginScreen.id);
  }
  String getTimeOfDay(){
    DateTime now = DateTime.now();
    return DateFormat.Hms().format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close,color: Colors.white,),
              onPressed: () async{
              signOut();
              }),
        ],
        title:  const Text('⚡️Chat',style: TextStyle(color:Colors.white),),
        backgroundColor: isGreenColor,
      ),
      body: SafeArea(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessagesStream(),
            Container(
              decoration: messageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        textMessage = value;
                        textMessage = value;
                      },
                      controller: messageTextController,
                      decoration: messageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages')
                          .add({
                        'text':textMessage,
                        'sender':loggedInUser.email,
                        'timestamp': getTimeOfDay(),
                      });
                      messageTextController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: isGreenColor,
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
class MessagesStream extends StatelessWidget{
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return   StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('timestamp',descending: true).snapshots(),
        builder: (context, snapshot)  {
          List<MessageBuble> messagesBubbles = [];
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
          
          final messages = snapshot.data!.docs;
          for (var message in messages){
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final timeOfDay = message.get('timestamp');
            final currentUser = loggedInUser.email;

            final messageBubble = MessageBuble(
              sender: currentUser == messageSender ? 'You':messageSender,
              text:  messageText,
              isMe: currentUser == messageSender,
              time: timeOfDay,
            );
            messagesBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              children: messagesBubbles,
            ),
          );
        }
        );
  }
}
