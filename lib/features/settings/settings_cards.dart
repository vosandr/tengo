import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cardoteka/cardoteka.dart';

// import 'package:flutter/material.dart' hide Card;

enum SettingsCards<T extends Object> implements Card<T> {
  isEditMode(DataType.bool, false),
  priorityFseName(DataType.string, '00.md'),
  patternFromLinks(DataType.string, r'(?<=\[\[).*?(?=\]\])'),
  startingPoint(DataType.string, './'),
  pathSeparator(DataType.string, '/'),
  ;

  const SettingsCards(this.type, this.defaultValue);
  @override
  final DataType type;

  @override
  final T defaultValue;

  @override
  String get key => name;

  static Map<SettingsCards, Converter> get converters => const {};
}

class SettingsCardoteka extends Cardoteka with WatcherImpl {
  SettingsCardoteka({required super.config});
}
