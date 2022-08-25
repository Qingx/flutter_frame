import 'package:get/get.dart';
import 'package:may/data/entity/user_entity.dart';
import 'package:rxdart/rxdart.dart';

class FourthController extends GetxController with StateMixin<UserEntity> {
  FourthController._();

  static const String tag = "fourthController";

  static void get put => Get.lazyPut<FourthController>(
        () => FourthController._(),
        fenix: true,
        tag: tag,
      );

  static FourthController get find => Get.find<FourthController>(tag: tag);

  // RxBool mStatus =false.obs;
  RxInt number = 0.obs;

  void doSomething() {
    // _doTest();
    Get.snackbar("hi", "message");

    // Get.defaultDialog(title: "hi message");

    // Get.bottomSheet(
    //   SizedBox(width: Get.width, height: Get.width / 2),
    //   backgroundColor: Colors.white,
    // );

    // Get.dialog(
    //   Center(child: Container(width: Get.width / 2, height: Get.width / 2, color: Colors.white)),
    // );
  }

  void _updateCount() {
    number.value += 1;
    update();
  }

  void _doTest() {
    List<UserEntity> list = [
      UserEntity(id: "1", name: "11"),
      UserEntity(id: "1", name: "12"),
      UserEntity(id: "2", name: "21"),
      UserEntity(id: "3", name: "31"),
      UserEntity(id: "3", name: "32"),
      UserEntity(id: "4", name: "41"),
    ];
    var set=list.map((e) => e.id).toSet();
    list.retainWhere((element) => set.remove(element.id));
    print("wangxiang:$list");
  }

  @override
  void onInit() {
    super.onInit();
    print("wangxiang:onInit()");

    Stream.fromFuture(Future.delayed(const Duration(milliseconds: 1000)))
        .flatMap((event) => Stream.error("sorry on error"))
        .onErrorReturn(UserEntity(phone: "11111111"))
        .listen(
      (event) {
        change(event, status: RxStatus.success());
      },
      onError: (error, stack) {
        change(UserEntity(), status: RxStatus.error(error.toString()));
      },
      onDone: () {},
    );
  }

  @override
  void onReady() {
    super.onReady();
    print("wangxiang:onReady()");

    Stream.periodic(const Duration(milliseconds: 1000)).take(60).listen((event) {
      _updateCount();
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("wangxiang:onClose()");
  }
}
