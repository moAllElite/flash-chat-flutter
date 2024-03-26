import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget{
  final String message;
  final BuildContext context ;
  final Icon icon;
  final String title;
  final String buttonName ;


  const CustomAlertDialog({required this.message,required this.context,required this.icon,required this.title,required this.buttonName, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title,textAlign: TextAlign.center,),
      content: Text(message),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(context);
        }
            , child: Text(buttonName)
        )
      ],
      icon: icon,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(25.0)
          )
      ),
    );
  }
}

