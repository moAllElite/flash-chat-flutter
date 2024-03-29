import 'package:chat/constants/custom_color.dart';
import 'package:flutter/material.dart';

var sendButtonTextStyle = TextStyle(
  color: isGreenColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const messageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

var messageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: isGreenColor, width: 2.0),
  ),
);


const animateKitTextStyle = TextStyle(
  fontSize: 45,
  fontWeight: FontWeight.w900,
);

var kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password',
  contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 20.0
  ),
  errorStyle: const TextStyle(
    fontSize: 16.0
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(32.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: isGreenColor, width: 1.0),
    borderRadius: BorderRadius.circular(32.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:  BorderSide(color: isGreenColor, width: 2.0),
    borderRadius: BorderRadius.circular(32.0),
  ),
);

const errorIcon = Icon(
  Icons.report_problem_outlined,
  color: Colors.red,
  size: 70.0,
);
const messageErrorStyle = TextStyle(
  fontWeight: FontWeight.w600,
);

