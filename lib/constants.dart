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


const animateKitTextStyle = TextStyle(
  fontSize: 45,
  fontWeight: FontWeight.w900,
  color: Colors.black54,
);

var kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.black54,
  ),
  hintText: 'Enter your email',
  fillColor: Colors.black54,
  contentPadding:
   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.circular(32.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.circular(32.0),
  ),
);