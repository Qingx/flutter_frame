import 'package:flutter/material.dart';
import 'package:qinghe_ios/controller/user_controller.dart';
import 'package:qinghe_ios/data/config/base_route.dart';

class FormFactory {
  static final Map<String, List<Widget>> _formMap = {
    BaseRoute.Initial: [],
    BaseRoute.Mine: [],
    BaseRoute.Third: [
      const PhoneForm(),
    ],
  };

  static List<Widget> flatMap(String routeName) {
    return _formMap[routeName] ?? [];
  }
}

class PhoneForm extends StatefulWidget {
  const PhoneForm({Key? key}) : super(key: key);

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: const InputDecoration(
          helperText: "",
          labelText: "PhoneNumber",
        ),
        onSaved: (value){
          UserController.to.setPhone(value!);
        },
        onChanged: (value) {},
        keyboardType: TextInputType.phone,
        validator: (value) {
          return value?.length != 11 ? "incorrect phone" : null;
        },
      ),
    );
  }
}
