
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum HeaderPattern {
  flag('#'),
  endFlag('\n'),
  ;

  const HeaderPattern(this.value);
  final String value;
}

class LinkText extends SpecialText {
  LinkText(
    TextStyle? textStyle, {
    this.start, this.numberHeader=1
  }) : super(HeaderPattern.flag.value*numberHeader, HeaderPattern.endFlag.value, textStyle);
  final int? start;
  final int numberHeader;
  @override
  InlineSpan finishText() {
    
    bool isHover = false;
    final String key = toString().substring(2, toString().length - 2);
    return TextSpan(
      text: HeaderPattern.flag.value,
      children: [
        TextSpan(
            style: TextStyle(
                color: Colors.deepPurple[800],
                decoration: TextDecoration.combine([TextDecoration.underline])),
            text: key,
            recognizer: TapGestureRecognizer()..onTap = () {},
            onEnter: (_) {
              if (isHover == false) {
                isHover = true;
              }
            },
            onExit: (_) {
              if (isHover == true) {
                isHover = false;
              }
            }),
        TextSpan(text: HeaderPattern.endFlag.value)
      ],
    );
    // if(){

    // }
    // // TODO: implement finishText
    // throw UnimplementedError();
  }
}

// class LinkUtil {
//   Link
// }
