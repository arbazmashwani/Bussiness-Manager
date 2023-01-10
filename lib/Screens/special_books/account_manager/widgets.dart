//dropdown textfield widgets,

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

dropDownWidgetsfield(
    //
    String text,
    List<DropDownValueModel> list,

    // ignore: use_function_type_syntax_for_parameters
    void function(dynamic)) {
  return DropDownTextField(
    textFieldDecoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      labelText: ' $text',
      labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
    ),
    enableSearch: true,
    dropDownItemCount: 6,
    dropDownList: list,
    onChanged: function,
  );
}

textwidets(
    String textString, Color? color, FontWeight? fontWeight, double? size) {
  return Text(
    textString,
    style: TextStyle(
      color: color!,
      fontWeight: fontWeight!,
    ),
  );
}

iconButtonWidget(
    IconData iconData, Color color, String text, void Function() ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: color,
        ),
        textwidets(text, Colors.black, FontWeight.bold, null),
      ],
    ),
  );
}
