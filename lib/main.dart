// ignore_for_file: prefer_const_constructors

import 'package:calculator/models/calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/display.dart';
import 'components/numpad.dart';

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onTapKeyButton = ref.read(calculatorProvider.notifier).process;
    final calulatorResult = ref.watch(calculatorProvider);

    final showCalculator = useState(true);

    return Scaffold(
      appBar: AppBar(
        title: Text(calulatorResult.result),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 250,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ToggleButtons(children: [
                IconButton(
                    onPressed: () {
                      showCalculator.value = !showCalculator.value;
                    },
                    icon: Icon(Icons.calculate))
              ], isSelected: [
                showCalculator.value
              ]),
              if (showCalculator.value) Display(),
              if (showCalculator.value)
                NumPad(
                  onTapKeyButton: onTapKeyButton,
                ),
              // Display(),
              // NumPad(
              //   onTapKeyButton: onTapKeyButton,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
