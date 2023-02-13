import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future<dynamic> doIsolate(int number) async {
    var receive0 = ReceivePort();
    var port0 = receive0.sendPort;
    await Isolate.spawn((sendPort) {
      // var receive1 = new ReceivePort();
      // var port1 = receive1.sendPort;
      // receive1.listen((message) {
      //   log(message);
      // });

      Stream.value(number).delay(const Duration(seconds: 3)).listen((event) {
        // sendPort.send(port1);
        sendPort.send(event);
      });
    }, port0);

    // SendPort port1;
    // receive0.listen((message) {
    //   if (message is SendPort) {
    //     port1 = message;
    //     port1.send("receive0==>message");
    //   }
    // });

    var value = await receive0.first;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
