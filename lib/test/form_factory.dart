import 'package:flutter/cupertino.dart';
import 'package:qinghe_ios/config/base_widget.dart';
import 'package:qinghe_ios/data/config/base_route.dart';

class FormBuilder {
  static final Map<String, Map<String, int>> formConfig = {
    BaseRoute.Initial: {
      "pwd": 0,
      "address": 1,
      "phone": 2,
    },
    BaseRoute.Mine: {
      "userName": 0,
      "email": 1,
    }
  };

  static final List<FormFactory> _formList = [
    UserNameForm(),
    PasswordForm(),
    AddressForm(),
    EmailForm(),
    PhoneForm(),
  ];

  static List<FormFactory> flatMap(String routeName) {
    var list = _formList.where((element) => element.routeName == routeName).toList();
    list.sort((a, b) => (FormBuilder.getIndex(a)).compareTo(FormBuilder.getIndex(b)));
    return list;
  }

  static int getIndex(FormFactory form) {
    return formConfig[form.routeName]![form.formName]!;
  }
}

abstract class FormFactory {
  late String routeName;
  late String formName;

  Widget createWidget(BuildContext context);

  Widget show(BuildContext context) => createWidget(context);
}

class UserNameForm extends FormFactory {
  @override
  String get routeName => BaseRoute.Mine;

  @override
  String get formName => "userName";

  @override
  Widget createWidget(BuildContext context) {
    return BaseWidget.testItemWidget(FormBuilder.getIndex(this), content: formName);
  }
}

class PasswordForm extends FormFactory {
  @override
  String get routeName => BaseRoute.Initial;

  @override
  String get formName => "pwd";

  @override
  Widget createWidget(BuildContext context) {
    return BaseWidget.testItemWidget(FormBuilder.getIndex(this), content: formName);
  }
}

class AddressForm extends FormFactory {
  @override
  String get routeName => BaseRoute.Initial;

  @override
  String get formName => "address";

  @override
  Widget createWidget(BuildContext context) {
    return BaseWidget.testItemWidget(FormBuilder.getIndex(this), content: formName);
  }
}

class PhoneForm extends FormFactory {
  @override
  String get routeName => BaseRoute.Initial;

  @override
  String get formName => "phone";

  @override
  Widget createWidget(BuildContext context) {
    return BaseWidget.testItemWidget(FormBuilder.getIndex(this), content: formName);
  }
}

class EmailForm extends FormFactory {
  @override
  String get routeName => BaseRoute.Mine;

  @override
  String get formName => "email";

  @override
  Widget createWidget(BuildContext context) {
    return BaseWidget.testItemWidget(FormBuilder.getIndex(this), content: formName);
  }
}
