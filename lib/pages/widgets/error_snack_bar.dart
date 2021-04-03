import 'package:flutter/material.dart';

class ErrorSnackBar {
  final String message;
  ErrorSnackBar({@required this.message});

  SnackBar snackbar() {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Column(
        children: [Text(message)],
      ),
    );
  }
}
