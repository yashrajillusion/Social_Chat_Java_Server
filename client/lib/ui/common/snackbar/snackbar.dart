import 'package:flutter/material.dart';

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}
