import 'package:FlutterFirebaseMeetup/src/widgets.dart';
import 'package:FlutterFirebaseMeetup/widgets/styled_button.dart';
import 'package:flutter/material.dart';

class GuestBook extends StatefulWidget {
  GuestBook({@required this.addMessage});
  final Future<void> Function(String message) addMessage;

  @override
  _GuestBookState createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Leave a message',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter your message to continue';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            StyledButton(
              child: Row(
                children: [
                  Icon(Icons.send),
                  SizedBox(width: 4),
                  Text('SEND'),
                ],
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await widget.addMessage(_controller.text);
                  _controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
