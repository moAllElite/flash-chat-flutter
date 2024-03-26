import 'package:flutter/material.dart';
SnackBar  MySnackBar ({
  required  Color backgroundColor,
  required String message,
}){
  return  SnackBar(
    elevation: 10.0,
    content: Row(
      children: [
        const Icon(
          Icons.report_problem_outlined,
          color: Colors.white,
          size: 22.0,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,

  );
}