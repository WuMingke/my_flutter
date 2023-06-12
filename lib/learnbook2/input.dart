import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  const MyInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color?>(Colors.red),
            padding: MaterialStatePropertyAll<EdgeInsetsGeometry?>(
              ButtonStyleButton.scaledPadding(
                const EdgeInsets.all(0),
                const EdgeInsets.all(0),
                const EdgeInsets.all(0),
                1,
              ),
            ),
          ),
          // child: Text('123'),
          child: Image.asset('images/head.jpg'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color?>(Colors.transparent),
          ),
          child: Image.asset('images/head.jpg'),
        ),
        CupertinoButton(
          color: Colors.grey,
          // pressedOpacity: 0,
          onPressed: () {},
          child: const Text('123'),
        ),
        const SizedBox(
          height: 10,
        ),
        const CupertinoTextField(
            // decoration: null,
            ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          readOnly: false,
          // obscureText: true,
          // obscuringCharacter: 's',
          maxLength: 10,
          selectionHeightStyle: BoxHeightStyle.max,
          selectionWidthStyle: BoxWidthStyle.max,
          keyboardType: TextInputType.number,
          // enableInteractiveSelection: false,
          // toolbarOptions: ToolbarOptions(),
          // contextMenuBuilder: (BuildContext context, EditableTextState editableTextState) {
          //   return AdaptiveTextSelectionToolbar.editableText(
          //     editableTextState: editableTextState,
          //   );
          // },
          // maxLines: 2,
          // minLines: 1,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.add,
            ),
            prefixIcon: Icon(Icons.co2),
            prefixText: 'input:',
            // counterText: '0/40',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIcon: Icon(Icons.delete),
            suffix: Icon(Icons.clear),
            hintText: 'this is hint',
            labelText: 'Date',
            helperText: "HELP",
            border: UnderlineInputBorder(),
          ),
          onSubmitted: (value) {
            print(value);
          },
        ),
      ],
    );
  }
}
