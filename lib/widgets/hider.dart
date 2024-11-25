import 'package:cardoteka/cardoteka.dart';
import 'package:flutter/material.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings_cards.dart';

class Hider extends StatelessWidget {
  Hider({required this.showWidget, required this.hideWidget, super.key});
  final Widget showWidget;
  final Widget hideWidget;
  final editingMode = SettingsCardoteka(
    config: CardotekaConfig(
        name: 'settings',
        cards: SettingsCards.values,
        converters: SettingsCards.converters),
  ).get(SettingsCards.isEditMode);
  @override
  Widget build(BuildContext context) {
    if (editingMode == true) {
      return showWidget;
    }
    return hideWidget;
  }

}
