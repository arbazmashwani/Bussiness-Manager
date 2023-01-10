import 'package:flutter/material.dart';

textfieldwidget(TextEditingController controller, String textlabel,
    void Function(value), int lines, int lines2, int maxlength, bool bools) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: TextField(
      readOnly: bools,
      maxLength: maxlength,
      controller: controller,
      minLines: lines,
      maxLines: lines2,
      onChanged: Function,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        label: Text(textlabel),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    ),
  );
}

textfieldwidget2(TextEditingController controller, String textlabel,
    void Function(value), int lines, int lines2, int maxlength, bool bools) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: TextField(
      readOnly: bools,
      controller: controller,
      minLines: lines,
      maxLines: lines2,
      onChanged: Function,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        label: Text(textlabel),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    ),
  );
}

textfieldwidget3(
    TextEditingController controller,
    String textlabel,
    void Function(value),
    int lines,
    int lines2,
    int maxlength,
    bool bools,
    bool obscure) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: TextField(
      obscureText: obscure,
      readOnly: bools,
      controller: controller,
      minLines: lines,
      maxLines: lines2,
      onChanged: Function,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        hintText: textlabel,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    ),
  );
}

textfields(TextEditingController controller, String textlabel, void function(),
    bool boolk) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: TextField(
      readOnly: boolk,
      onTap: function,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        labelText: textlabel,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    ),
  );
}

textfieldwidgetmaxlength(TextEditingController controller, String textlabel,
    void Function(value), int lines, int lines2, int maxlength, bool bools) {
  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: TextField(
      maxLength: maxlength,
      readOnly: bools,
      controller: controller,
      minLines: lines,
      maxLines: lines2,
      onChanged: Function,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38, width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        label: Text(textlabel),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
      ),
    ),
  );
}
