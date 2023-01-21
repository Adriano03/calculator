// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(82, 82, 82, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);

  final String text;
  final bool big;
  final Color color;
  final void Function(String) cb;

  const Button({
    super.key,
    required this.text,
    this.big = false,
    this.color = DEFAULT,
    required this.cb,
  });

  const Button.big({
    super.key,
    required this.text,
    this.big = true,
    this.color = DEFAULT,
    required this.cb,
  });

  const Button.operation({
    super.key,
    required this.text,
    this.big = false,
    this.color = OPERATION,
    required this.cb,
  });
  const Button.dark({
    super.key,
    required this.text,
    this.big = false,
    this.color = DARK,
    required this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: const BorderSide(width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w200,
          ),
        ),
        onPressed: () => cb(text),
      ),
    );
  }
}
