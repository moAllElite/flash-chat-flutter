import 'package:flutter/material.dart';

const sendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const messageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const messageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);



AlertDialog myAlertDialogue(
    Widget widget,
    { required BuildContext context ,
      required Route route,
      required String title,
      required String message
    }
    ){
  return AlertDialog.adaptive(
    title: Text(title),
    content: widget,
    actions: [
      TextButton(onPressed: (){
        Navigator.of(context).push(route);
      }
          , child: Text(message)
      )
    ],
    shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(15.0)
        )
    ),
  );
}