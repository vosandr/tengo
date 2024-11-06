import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tengo/open_source/menu_anchor.dart';

enum ContextMenuMode {
  primaryKey,
  secondaryKey,
}

class ContextMenu extends StatefulWidget {
  const ContextMenu({
    super.key,
    required this.menuChildren,
    required this.child,
    this.menuMode = ContextMenuMode.secondaryKey,
    this.disabled,
  });
  final List<Widget> menuChildren;
  final Widget child;
  final ContextMenuMode menuMode;
  final bool? disabled;
  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  final MenuController _menuController = MenuController();
  final FocusNode _buttonFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    if (widget.disabled == false) {
      return GestureDetector(
          onSecondaryTapDown: widget.menuMode == ContextMenuMode.secondaryKey
              ? _handleSecondaryTapDown
              : null,
          onTapDown: _handleTapDown,
          child: MenuAnchor(
              childFocusNode: _buttonFocusNode,
              controller: _menuController,
              menuChildren: widget.menuChildren,
              child: widget.child));
    }
    return widget.child;
  }

  void _handleSecondaryTapDown(TapDownDetails details) {
    _menuController.open(position: details.localPosition);
  }

  void _handleTapDown(TapDownDetails details) {
    if (_menuController.isOpen) {
      _menuController.close();
      return;
    }
    if (widget.menuMode == ContextMenuMode.primaryKey) {
      _menuController.open();
      return;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        // Don't open the menu on these platforms with a Ctrl-tap (or a
        // tap).
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        // Only open the menu on these platforms if the control button is down
        // when the tap occurs.
        if (HardwareKeyboard.instance.logicalKeysPressed
                .contains(LogicalKeyboardKey.controlLeft) ||
            HardwareKeyboard.instance.logicalKeysPressed
                .contains(LogicalKeyboardKey.controlRight)) {
          _menuController.open(position: details.localPosition);
        }
    }
  }
}
