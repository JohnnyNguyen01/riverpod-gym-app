import 'package:flutter/material.dart';

class TickBox extends StatefulWidget {
  @override
  _TickBoxState createState() => _TickBoxState();
}

class _TickBoxState extends State<TickBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: !isChecked ? Colors.grey.shade200 : Color(0xFF2FCD70),
          border: Border.all(
            color: !isChecked ? Colors.grey.shade200 : Color(0xFF2FCD70),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          Icons.check,
          color: !isChecked ? Colors.grey : Colors.white,
        ),
      ),
      onTapDown: (_) {},
      onTap: handleOnTap,
    );
  }

  void handleOnTap() {
    setState(() {
      isChecked = !isChecked;
    });
  }
}
