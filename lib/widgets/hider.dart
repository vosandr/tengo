import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/another_windows/settings_model.dart';
import 'package:tengo/main.dart';

class Hider extends StatelessWidget {
  Hider({required this.showWidget, required this.hideWidget, super.key});
  final Widget showWidget;
  final Widget hideWidget;
  final bool editingMode = SettingsModel().editingMode;
  @override
  Widget build(BuildContext context) {
    if (editingMode == true) {
      return showWidget;
    }
    return hideWidget;
  }

}
