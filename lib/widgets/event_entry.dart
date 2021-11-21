import 'package:flutter/material.dart';

class EventEntry extends StatelessWidget {
  const EventEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text('here'),
        Text('be'),
        Text('dragons'),
      ],
    );
  }
}
