
import 'package:flutter/material.dart';

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