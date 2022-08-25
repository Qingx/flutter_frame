import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:may/controller/user_controller.dart';
import 'package:may/data/config/base_route.dart';
import 'package:may/config/base_extension.dart';

class FormFactory {
  static final Map<String, List<Widget>> _formMap = {
    BaseRoute.Initial: [],
    BaseRoute.Second: [],
    BaseRoute.Third: [
      const EmailForm(),
    ],
  };

  static List<Widget> flatMap(String routeName) {
    return _formMap[routeName] ?? [];
  }
}

class EmailForm extends StatelessWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Your email",
      ),
      onSaved: (value) => UserController.to.setPhone(value!),
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z]"))],
      validator: (value) {
        return value!.isNotEmpty ? null : "Invalid Email";
      },
    ).marginOn(left: 16, right: 16);
  }
}
