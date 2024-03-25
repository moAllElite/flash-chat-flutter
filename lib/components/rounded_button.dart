import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  late String title;
  late Color color;
  late dynamic onPressed;
  RoundedButton({required this.title,required this.color,required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: ()  {
               onPressed();
            },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title
          ),
        ),
      ),
    );
  }

}

