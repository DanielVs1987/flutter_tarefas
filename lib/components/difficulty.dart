import 'package:flutter/material.dart';
import 'task.dart';

class Difficulty extends StatelessWidget {
  const Difficulty({
    super.key,
    required this.widget,
  });

  final Task widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color:
          (widget.difficulty >= 1)
              ? Colors.blue
              : Colors.blue[100],
          size: 15,
        ),
        Icon(
          Icons.star,
          color:
          (widget.difficulty >= 2)
              ? Colors.blue
              : Colors.blue[100],
          size: 15,
        ),
        Icon(
          Icons.star,
          color:
          (widget.difficulty >= 3)
              ? Colors.blue
              : Colors.blue[100],
          size: 15,
        ),
        Icon(
          Icons.star,
          color:
          (widget.difficulty >= 4)
              ? Colors.blue
              : Colors.blue[100],
          size: 15,
        ),
        Icon(
          Icons.star,
          color:
          (widget.difficulty >= 5)
              ? Colors.blue
              : Colors.blue[100],
          size: 15,
        ),
      ],
    );
  }
}