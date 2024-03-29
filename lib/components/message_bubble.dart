import 'package:flutter/material.dart';
import '../constants/custom_color.dart';

class MessageBuble extends StatelessWidget{
  const MessageBuble({super.key, required this.sender, required this.text, required this.isMe, required this.time});
  final String sender;
  final String text;
  final bool isMe;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children:<Widget> [
          Text(
            sender,
            style:  const TextStyle(
              color: Colors.black54,
              fontSize: 13.8,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe ?  const BorderRadius.only(
              topLeft:   Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight:  Radius.circular(30.0),
            ): const BorderRadius.only(
              topRight:  Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight:  Radius.circular(30.0),
            ),
            color: isMe  ? isGreenColor:Colors.white,
            child: Padding(
              padding:  const EdgeInsets.symmetric(
                  horizontal: 12.0 ,
                  vertical: 10.0
              ),
              child: Text(
                text ,
                style:  TextStyle(
                    fontSize: 15.0,
                  color: isMe ?  Colors.white : Colors.black54
                ),
              ),
            ),
          ),
          const SizedBox(
              height: 8.0,
            ),
          Text(
            time.substring(0,5),
            style: const TextStyle(
              fontSize: 13.5
            ),
          )
        ],
      ),
    );
  }

}