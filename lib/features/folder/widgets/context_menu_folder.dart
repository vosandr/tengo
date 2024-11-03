import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide SubmenuButton, MenuController, MenuAnchor, MenuItemButton;
import 'package:flutter/services.dart';
import 'package:tengo_editor/open_source/menu_anchor.dart';
import 'package:tengo_editor/repositories/fse/models/fse.dart';


class FolderContextMenu extends StatefulWidget {
  const FolderContextMenu({super.key, required this.child, required this.fse});
  final Widget child;
  final Fse fse;
  @override
  State<FolderContextMenu> createState() => _FolderContextMenuState();
}

class _FolderContextMenuState extends State<FolderContextMenu> {
  final MenuController _menuController = MenuController();
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
        onSecondaryTapDown: _handleSecondaryTapDown,
        onTapDown: _handleTapDown,
        child: MenuAnchor(
          
          // alignmentOffset: Offset(100, 100),
          childFocusNode: _buttonFocusNode,
          controller: _menuController,
          menuChildren: [
            SubmenuButton(
              
              child: Icon(Icons.add),
              menuChildren: [SizedBox(width: 100, child: TextField(onEditingComplete: () {},))],
            ),
            SubmenuButton(
              
              child:  Icon(Icons.drive_file_rename_outline),
              menuChildren: [SizedBox(width: 100, child: TextField(onEditingComplete: () {},))],
            ),
            MenuItemButton(onPressed: () {}, child: Icon(Icons.remove),),
            // MenuItemButton(onPressed: () {}, child: Icon(Icons.copy)),
            // MenuItemButton(onPressed: () {}, child: Icon(Icons.cut)),
            // MenuItemButton(onPressed: () {}, child: Icon(Icons.paste)),
          ],
          child: widget.child,
        ));
  }

  void _handleSecondaryTapDown(TapDownDetails details) {
    _menuController.open(position: details.localPosition);
  }

  void _handleTapDown(TapDownDetails details) {
    if (_menuController.isOpen) {
      _menuController.close();
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
