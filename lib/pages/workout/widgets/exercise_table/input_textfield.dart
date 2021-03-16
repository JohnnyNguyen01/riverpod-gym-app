import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  // final int keyValue;
  final TextEditingController controller;
  InputTextField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      height: 39,
      width: 80,
      child: TextFormField(
        // key: Key(keyValue.toString()),
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        validator: (value) {
          if (value.isEmpty) {
            return "Incorrect";
          } else
            return null;
        },
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5, left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1),
          ),
        ),
        // onChanged: (value) => print(
        //   controller.toString(),
        // ),
        onTap: () => print(controller.toString()),
      ),
    );
  }
}
