import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KeyButoon extends HookWidget {
  final dynamic label;
  final String? code;
  final Function(String)? onTap;
  const KeyButoon({
    Key? key,
    required this.label,
    this.onTap,
    this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!(code ?? label.toString());
          }
        },
        child: Center(
          child: Text(label.toString()),
        ),
      ),
    );
  }
}
