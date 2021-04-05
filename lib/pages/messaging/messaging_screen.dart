import 'package:flutter/material.dart';

class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat',
            style: textTheme.headline5.copyWith(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: _buildInputRow(),
    );
  }

  Widget _buildInputRow() {
    final _inputController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              onChanged: (_) => print(_inputController.text),
            ),
          ),
          const SizedBox(width: 14),
          ElevatedButton(
            child: Text('Send'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
