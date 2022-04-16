import 'package:calculator/models/calculator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Display extends HookConsumerWidget {
  const Display({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calulatorResult = ref.watch(calculatorProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(calulatorResult.result),
            ),
          )),
    );
  }
}
