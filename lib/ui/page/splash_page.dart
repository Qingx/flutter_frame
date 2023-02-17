import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isolate/isolate.dart';
import 'package:may/config/base_extension.dart';
import 'package:may/config/base_widget.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  doClick() async {
    // Get.toNamed(BaseRoute.Fourth);

    // log("onClick:0");
    // doTestFuture();
    // log("onClick:1");

    // var result = doTestCountNum();
    // var result = await doTestCompute();
    // var result = await doAwaitCountNum();
    // var result = await doTestIsolate();
    // var result = await doTestLoadBalancer();
    // doTestEventLoop();
    // log("result:$result");
  }

  Future<void> doTestFuture() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) => log("doTestFuture"));
  }

  int doTestCountNum({int number = 100000000000}) {
    var result = 0;
    while (number > 0) {
      result = result + number;
      number--;
      log("doTestCountNum:$result");
    }
    return result;
  }

  FutureOr<int> doAwaitCountNum({int number = 100000000000}) async {
    var result = 0;
    while (number > 0) {
      result = result + number;
      number--;
      log("doAwaitCountNum:$result");
    }
    return result;
  }

  Future<int> doTestCompute({int number = 100000000000}) async {
    var result = await compute((value) async {
      var result = 0;

      while (value > 0) {
        result = result + value;
        value--;
        log("doTestCompute:$result");
      }

      result = await Stream.value(result).delay(const Duration(seconds: 1)).last;

      return result;
    }, number);

    return result;
  }

  Future<int> doTestIsolate({int number = 100000000000}) async {
    var receive0 = ReceivePort();
    var port0 = receive0.sendPort;

    Isolate isolate = await Isolate.spawn((port0) async {
      var receive1 = ReceivePort();
      var port1 = receive1.sendPort;

      receive1.listen((message) {
        log(message);
      });

      // var result = 0;
      // while (number > 0) {
      //   result = result + number;
      //   number--;
      //   log("doTestIsolate:$result");
      // }

      // result = await Stream.value(result).delay(const Duration(seconds: 1)).last;
      port0.send(port1);

      // port0.send(result);
    }, port0);

    // SendPort port1;
    // receive0.listen((message) {
    //   if (message is SendPort) {
    //     SendPort port1 = message;
    //     port1.send("receive0==>message");
    //   }
    // });

    // var value = await receive0.first;
    // var value = await receive0.firstWhere((element) => false);

    // isolate.kill();
    return 1;
  }

  Future<int> doTestLoadBalancer() async {
    LoadBalancer loadBalancer = await LoadBalancer.create(2, IsolateRunner.spawn);
    return await loadBalancer.run((value) {
      var result = 0;
      while (value > 0) {
        result = result + value;
        value--;
        log("doTestLoadBalancer:$result");
      }
      return result;
    }, 100000000000);
  }

  void doTestEventLoop() {
    scheduleMicrotask(() => log("microTask:0"));

    Future.delayed(const Duration(seconds: 1), () => log("event delay"));

    Future(() => log("event:0")).then((value) => log("event:1"));

    Future(() => log("event:2")).then((value) {
      Future(() => log("event:3"));
      scheduleMicrotask(() => log("microTask:1"));
    });

    scheduleMicrotask(() => log("microTask:2"));
    Future.microtask(() => log("microTask:3"));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseWidget.appBar(title: "Splash"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 80),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color: Theme.of(context).toggleableActiveColor,
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
            ).onClick(() async {
              // Get.toNamed(BaseRoute.Fourth);

              // log("onClick:0");
              // doTestFuture();
              // log("onClick:1");

              // // var result = doTestCountNum();
              // // var result = await doTestCompute();
              // // var result = await doAwaitCountNum();
              // // var result = await doTestIsolate();
              // var result = await doTestLoadBalancer();
              doTestEventLoop();
              // log("result:$result");
            }),
          ],
        ),
      ),
    );
  }
}
