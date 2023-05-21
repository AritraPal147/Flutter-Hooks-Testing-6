import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Hooks Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

const url = 'https://bit.ly/3x7J5Qt';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;

    controller = useStreamController<double>(
      /// Set the initial default value of controller to zero,
      /// i.e., the rotation angle of the image is initially zero.
      onListen: () => controller.sink.add(0.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: StreamBuilder<double>(
          stream: controller.stream,
          builder: (context, snapshot) {
            /// Checks if snapshot of stream does not have data
            /// If snapshot does not have data, a CircularProgressIndicator is shown.
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              // If snapshot has data, the data is stored into variable [rotation].
              final rotation = snapshot.data ?? 0.0;
              return GestureDetector(
                /// Increases rotation value by 10 every time the image is tapped on.
                onTap: () {
                  controller.sink.add(rotation + 10.0);
                },
                child: RotationTransition(
                  /// The value required by AlwaysStoppedAnimation is in radians, so
                  /// we divide the current value of rotation by 360
                  turns: AlwaysStoppedAnimation(rotation / 360),
                  child: Center(
                    child: Image.network(url),
                  ),
                ),
              );
            }
          }),
    );
  }
}
