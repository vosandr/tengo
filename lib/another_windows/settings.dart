// import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/another_windows/settings_model.dart';
import 'package:tengo/main.dart';
// import 'package:tengo/another_windows/event_widget.dart';

class Settings extends StatefulWidget {
  // final SharedPreferences prefs = SharedPreferences.getInstance();
  const Settings({super.key});
  
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.grid_3x3)),
      ),
      body: Column(
        // direction: Axis.vertical,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                // flex: 1,
                child: Icon(
                  Icons.drive_file_rename_outline_sharp,
                ),
              ),
              Spacer(flex: 4),
              Flexible(
                // flex: 1,
                child: InkWell(
                  focusColor: Colors.black,
                  onTap: () async {
                    // var prefs = await SharedPreferences.getInstance();
                    // prefs.get('editingMode')
                    // prefs.setBool('editingMode', true);
                    // SettingsModel().changeEditingMode();
                  },
                  customBorder: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(cornerRadius: 9)),
                  child: Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                        color: Colors.amber,
                        // color: SettingsModel().editingMode == false
                        //     ? Colors.grey[600]?.withOpacity(0.5)
                        //     : Colors.purple,
                        shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(cornerRadius: 9))),
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 24),
                      children: [
                        TextSpan(text: '600'),
                        WidgetSpan(child: Icon(Icons.currency_ruble_sharp)),
                        TextSpan(text: '/'),
                        WidgetSpan(child: Icon(Icons.calendar_month_sharp)),
                      ]),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                // flex: 1,
                child: Icon(
                  Icons.home_filled,
                ),
              ),
              Spacer(flex: 4),
              Flexible(
                // flex: 1,
                child: InkWell(
                  focusColor: Colors.black,
                  onTap: () {
                    // SettingsModel().changeEditingMode();
                  },
                  customBorder: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(cornerRadius: 9)),
                  child: Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(12),
                    decoration: ShapeDecoration(
                        color: Colors.amber,
                        // color:  == false
                        //     ? Colors.grey[600]?.withOpacity(0.5)
                        //     : Colors.purple,
                        shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(cornerRadius: 9))),
                  ),
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(helperText: '00.md'),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
