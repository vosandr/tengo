class SettingsModel {
  SettingsModel({this.editingMode = false});

  bool editingMode;
  void changeEditingMode() => editingMode = !editingMode;
}
