// ignore_for_file: prefer_const_constructors
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:calculator/models/calculator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/display.dart';
import 'components/numpad.dart';

void main() async {
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

    useEffect(() {
      debugPrint('::: starting http server');
      Future.microtask(() async {
        if (!kIsWeb) {
          final handler = const Pipeline()
              .addMiddleware(logRequests())
              .addHandler((Request request) {
            final q = request.url.queryParameters['q'] ?? '';

            q.split('').forEach((c) {
              debugPrint('onTap $c');
              onTapKeyButton(c);
            });
            final newCalculation = ref.watch(calculatorProvider);
            return Response.ok(
                'Request for "${request.url.queryParameters}, result: ${newCalculation.result}');
          });

          final server = await shelf_io.serve(handler, 'localhost', 8080);

          // Enable content compression
          server.autoCompress = true;

          debugPrint(
              '::: Serving at http://${server.address.host}:${server.port}');
        } else {
          debugPrint('::: http server not supported on web');
        }
      });

      return null;
    }, []);

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
