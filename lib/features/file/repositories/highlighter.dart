import 'package:cardoteka/cardoteka.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tengo/features/file/repositories/flr_change/rendering/object.dart';
// import 'package:flutter/material.dart';
import './flr_change/rendering/editable.dart';
import 'package:tengo/features/file/repositories/links_repository.dart';
import 'package:tengo/features/settings/settings_cards.dart';

// class ColoredTextEditingController extends TextEditingController {
//   ColoredTextEditingController({String text = ''}) : super(text: text);

//   // final regExp = RegExp(
//   //   r'(?<string>"[^"]*")|(?<number>\b-?[0-9][0-9\.]*\b)|'
//   //   r'(?<keyword>\btrue\b|\bfalse\b|\bnull\b)',
//   // );

//   List<InlineSpan> _syntaxHighlight(String text, TextStyle style) {
//     final TextStyle linkHighlightStyle =
//         style.merge(const TextStyle(color: Colors.deepPurpleAccent));
//     // final TextStyle numberHighlightStyle =
//     //     style.merge(const TextStyle(color: Colors.blue));
//     // final TextStyle keywordHighlightStyle =
//     //     style.merge(const TextStyle(color: Colors.purple));
//     final TextStyle defaultTextStyle = style.merge(const TextStyle());
//     final matches = regExp.allMatches(text).toList();
//     final spans = <InlineSpan>[];

//     var cursor = 0;
//     for (final match in matches) {
//       TextStyle style;
//       if (match.namedGroup('string') != null) {
//         style = linkHighlightStyle;
//       }
//       // else if (match.namedGroup('number') != null) {
//       //   style = numberHighlightStyle;
//       // } else if (match.namedGroup('keyword') != null) {
//       //   style = keywordHighlightStyle;
//       // }
//       else {
//         style = defaultTextStyle;
//       }
//       spans.add(TextSpan(text: text.substring(cursor, match.start)));
//       spans.add(
//         TextSpan(
//           text: text.substring(match.start, match.end),
//           style: style,
//         ),
//       );
//       cursor = match.end;
//     }
//     spans.add(TextSpan(text: text.substring(cursor, text.length)));
//     return spans;
//   }

//   @override
//   TextSpan buildTextSpan(
//       {required BuildContext context,
//       TextStyle? style,
//       required bool withComposing}) {
//     style = style ?? TextStyle();
//     if (!value.composing.isValid || !withComposing) {
//       return TextSpan(
//         style: style,
//         children: _syntaxHighlight(text, style),
//       );
//     }
//     final TextStyle composingStyle = style.merge(
//       const TextStyle(decoration: TextDecoration.underline),
//     );
//     return TextSpan(
//       style: style,
//       children: <TextSpan>[
//         TextSpan(
//             children: _syntaxHighlight(
//                 value.composing.textBefore(value.text), style)),
//         TextSpan(
//           style: composingStyle,
//           children:
//               _syntaxHighlight(value.composing.textInside(value.text), style),
//         ),
//         TextSpan(
//             children:
//                 _syntaxHighlight(value.composing.textAfter(value.text), style)),
//       ],
//     );
//   }
// }

class ContentTextEditingController extends TextEditingController {
  ContentTextEditingController(
      {String text = '',
      required this.settings,
      required this.style,
      required this.context,
      required this.path})
      : super(text: text);
  final SettingsCardoteka settings;
  final TextStyle style;
  final String path;
  final BuildContext context;
  List<InlineSpan> _syntaxHighlight(String text, TextStyle style) {
    final TextStyle linkHighlightStyle = style.merge(TextStyle(
        color: Colors.deepPurple[800], decoration: TextDecoration.underline));
    // final TextStyle stringHighlightStyle =
    //     style.merge(const TextStyle(color: Colors.green));
    // final TextStyle numberHighlightStyle =
    //     style.merge(const TextStyle(color: Colors.blue));
    // final TextStyle keywordHighlightStyle =
    //     style.merge(const TextStyle(color: Colors.purple));
    final TextStyle defaultHighlightStyle = style.merge(const TextStyle());
    final regExp =
        RegExp('(?<link>${settings.get(SettingsCards.patternFromLinks)})|'
            // r'(?<string>"[^"]*")|(?<number>\b-?[0-9][0-9\.]*\b)|'
            // r'(?<keyword>\btrue\b|\bfalse\b|\bnull\b)',
            );
    final matches = regExp.allMatches(text).toList();
    final spans = <InlineSpan>[];

    var cursor = 0;
    for (final match in matches) {
      var startMatch = match.start;
      var endMatch = match.end;
      GestureRecognizer? recognizer;
      TextStyle style;

      if (match.namedGroup('link') != null) {
        style = linkHighlightStyle;
        startMatch += 2;
        endMatch -= 2;
        recognizer = TapGestureRecognizer()
          ..onTap = () => LinksRepository(
                context: context,
                link: text.substring(startMatch, endMatch),
                path: path,
                selection: selection,
              )..onTapLink();
      }
      // else if (match.namedGroup('string') != null) {
      //   style = stringHighlightStyle;
      // } else if (match.namedGroup('number') != null) {
      //   style = numberHighlightStyle;
      // } else if (match.namedGroup('keyword') != null) {
      //   style = keywordHighlightStyle;
      // }
      else {
        style = defaultHighlightStyle;
      }
      spans.add(TextSpan(text: text.substring(cursor, startMatch)));
      spans.add(TextSpan(
          text: text.substring(startMatch, endMatch),
          recognizer: recognizer,
          style: style));
      cursor = endMatch;
    }
    spans.add(TextSpan(text: text.substring(cursor, text.length)));
    return spans;
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    style = style ?? const TextStyle();

    if (!value.composing.isValid || !withComposing) {
      return TextSpan(
        style: style,
        children: _syntaxHighlight(text, style),
      );
    }
    final TextStyle composingStyle = style.merge(
      const TextStyle(decoration: TextDecoration.underline),
    );
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(
            children: _syntaxHighlight(
                value.composing.textBefore(value.text), style)),
        TextSpan(
          style: composingStyle,
          children:
              _syntaxHighlight(value.composing.textInside(value.text), style),
        ),
        TextSpan(
            children:
                _syntaxHighlight(value.composing.textAfter(value.text), style)),
      ],
    );
  }
}
// class ContentTextEditingController extends TextEditingController {
//   ContentTextEditingController({required Cardoteka settings, required String text});
//   List<InlineSpan> _syntaxHighlight(String text, TextStyle style) {
//     return [TextSpan(text: text)];
//   }

//   @override
//   TextSpan buildTextSpan(
//       {required BuildContext context,
//       TextStyle? style,
//       required bool withComposing}) {
//     return super.buildTextSpan(
//         context: context, style: style, withComposing: withComposing);
//   }
// }

// class FruitColorizer extends TextEditingController {
//   final HighlightConfiguration configuration;
//   final Pattern pattern;

//   FruitColorizer(this.mapping)
//       : pattern =
//             RegExp(mapping.keys.map((key) => RegExp.escape(key)).join('|'));

//   FruitColorizer.fromColors(Map<String, Color> colorMap)
//       : this(colorMap
//             .map((text, color) => MapEntry(text, TextStyle(color: color))));

//   @override
//   TextSpan buildTextSpan(
//       {required BuildContext context,
//       TextStyle? style,
//       required bool withComposing}) {
//     List<InlineSpan> children = [];

//     text.splitMapJoin(
//       pattern,
//       onMatch: (Match match) {
//         children.add(
//             TextSpan(text: match[0], style: style?.merge(mapping[match[0]])));
//         return match[0] ?? '';
//       },
//       onNonMatch: (String text) {
//         children.add(TextSpan(text: text, style: style));
//         return text;
//       },
//     );
//     return TextSpan(style: style, children: children);
//   }
// }

// class HighlightConfiguration {
// }
