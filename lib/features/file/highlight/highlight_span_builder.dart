import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:tengo/features/file/highlight/md/link_text/link_text.dart';

class HighlightSpanBuilder extends SpecialTextSpanBuilder {
  HighlightSpanBuilder({required this.context, required this.selection, required this.path});
  final BuildContext context;
  final TextSelection selection;
  final String path;
  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    // debugPrint(index.toString());
    if (flag == '') {
      return null;
    }
    if (isStart(flag, LinkPattern.flag.value)) {
      return LinkText(
        style: textStyle,
        index: index,
        context: context,
        path: path
        // selection: selection,
      );
    }
    return null;
  }
}
