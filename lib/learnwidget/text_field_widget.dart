import 'package:flutter/material.dart';

class TextFieldTest extends StatelessWidget {
  const TextFieldTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _user = "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          autofocus: false,
          decoration: const InputDecoration(
            labelText: "用户名：",
            hintText: "用户名或邮箱：",
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: (v) {
            _user = v;
          },
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: "密码：",
            hintText: "请输入密码",
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        )
      ],
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  const FocusTestRoute({Key? key}) : super(key: key);

  @override
  State<FocusTestRoute> createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            focusNode: focusNode1,
            decoration: const InputDecoration(
              labelText: "input1",
            ),
          ),
          TextField(
            focusNode: focusNode2,
            decoration: const InputDecoration(
              labelText: "input2",
            ),
          ),
          Builder(builder: (context) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      focusScopeNode ??= FocusScope.of(context);
                      focusScopeNode?.requestFocus(focusNode2);
                    },
                    child: const Text("移动焦点")),
                ElevatedButton(
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                    child: const Text("隐藏键盘")),
              ],
            );
          })
        ],
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  const FormTestRoute({Key? key}) : super(key: key);

  @override
  State<FormTestRoute> createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            controller: _unameController,
            decoration: const InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              icon: Icon(Icons.person),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "用户名不能为空";
            },
          ),
          TextFormField(
            controller: _pwdController,
            decoration: const InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
            //校验密码
            validator: (v) {
              return v!.trim().length > 5 ? null : "密码不能少于6位";
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if ((_formKey.currentState as FormState).validate()) {
                        print("登录登录登录登录登录");
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("登录"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
