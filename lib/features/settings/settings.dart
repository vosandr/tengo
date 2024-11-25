// import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'dart:io';

import 'package:cardoteka/cardoteka.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tengo/another_windows/cubit/settings_cubit.dart';
import 'package:tengo/features/settings/settings_cards.dart';
import 'package:tengo/main.dart';
// import 'package:tengo/another_windows/event_widget.dart';

class Settings extends StatefulWidget {
  // final SharedPreferences prefs = SharedPreferences.getInstance();
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final cardoteka = SettingsCardoteka(
    config: CardotekaConfig(
        name: 'settings',
        cards: SettingsCards.values,
        converters: SettingsCards.converters),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.grid_3x3)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              border: TableBorder.all(style: BorderStyle.none),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(8),
                2: FixedColumnWidth(38),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(7),
              },
              // direction: Axis.vertical,
              children: [
                TableRow(

                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // textBaseline: TextBaseline.alphabetic,
                    children: [
                      const TableCell(
                        child: Icon(
                          Icons.drive_file_rename_outline,
                        ),
                      ),
                      const TableCell(child: SizedBox.shrink()),
                      // Spacer(flex: 4),
                      TableCell(
                        child: InkWell(
                          focusColor: Colors.black,
                          onTap: () async {
                            setState(() {
                              cardoteka.set(SettingsCards.isEditMode,
                                  !(cardoteka.get(SettingsCards.isEditMode)));
                            });
                            // var prefs = await SharedPreferences.getInstance();
                            // prefs.get('editingMode')
                            // prefs.setBool('editingMode', true);
                            // SettingsModel().changeEditingMode();
                          },
                          customBorder: SmoothRectangleBorder(
                              borderRadius:
                                  SmoothBorderRadius(cornerRadius: 9)),
                          child: Container(
                            width: 38,
                            height: 38,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                                // color: Colors.amber,
                                color:
                                    cardoteka.get(SettingsCards.isEditMode) ==
                                            false
                                        ? Colors.grey[600]?.withOpacity(0.5)
                                        : Colors.purple,
                                shape: SmoothRectangleBorder(
                                    borderRadius:
                                        SmoothBorderRadius(cornerRadius: 14))),
                          ),
                        ),
                      ),
                      const TableCell(child: SizedBox.shrink()),
                      TableCell(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                              children: [
                                TextSpan(text: '600'),
                                WidgetSpan(
                                    child: Icon(Icons.currency_ruble_sharp)),
                                TextSpan(text: '/'),
                                WidgetSpan(
                                    child: Icon(Icons.calendar_month_sharp)),
                              ]),
                        ),
                      )
                    ]),
                TableRow(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // textBaseline: TextBaseline.alphabetic,
                    children: [
                      TableCell(
                        child: Center(
                          child: RichText(
                            text: const TextSpan(children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.file_present_sharp,
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.home_filled,
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),

                      // Spacer(flex: 8),
                      // Flexible(
                      //   // flex: 1,
                      //   child: InkWell(
                      //     focusColor: Colors.black,
                      //     onTap: () {
                      //       // SettingsModel().changeEditingMode();
                      //     },
                      //     customBorder: SmoothRectangleBorder(
                      //         borderRadius: SmoothBorderRadius(cornerRadius: 9)),
                      //     child: Container(
                      //       width: 24,
                      //       height: 24,
                      //       padding: const EdgeInsets.all(12),
                      //       decoration: ShapeDecoration(
                      //           color: cardoteka.get(SettingsCards.priorityFseName) == false
                      //               ? Colors.grey[600]?.withOpacity(0.5)
                      //               : Colors.purple,
                      //           shape: SmoothRectangleBorder(
                      //               borderRadius: SmoothBorderRadius(cornerRadius: 9))),
                      //     ),
                      //   ),
                      // ),
                      const TableCell(child: SizedBox.shrink()),
                      TableCell(
                          child: IconButton(
                              onPressed: () {
                                cardoteka.set(SettingsCards.priorityFseName,
                                    SettingsCards.priorityFseName.defaultValue);
                                setState(() {});
                              },
                              icon: const Icon(Icons.refresh))),
                      const TableCell(child: SizedBox.shrink()),
                      TableCell(
                        child: TextField(
                          // expands: true,
                          maxLines: 1,
                          minLines: null,
                          controller: TextEditingController(
                              text:
                                  cardoteka.get(SettingsCards.priorityFseName)),
                          onSubmitted: (value) {
                            cardoteka.set(SettingsCards.priorityFseName, value);
                            // cardoteka.get(SettingsCards.priorityFseName);
                            setState(() {});
                          },
                        ),
                      )
                    ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: RichText(
                        text: const TextSpan(children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.folder,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.home_filled,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  const TableCell(child: SizedBox.shrink()),
                  TableCell(
                      child: IconButton(
                          onPressed: () {
                            cardoteka.set(SettingsCards.startingPoint,
                                SettingsCards.startingPoint.defaultValue);
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh))),
                  const TableCell(child: SizedBox.shrink()),
                  TableCell(
                    child: TextField(
                      // readOnly: true,
                      // expands: true,
                      maxLines: 1,
                      minLines: null,
                      controller: TextEditingController(
                          text: cardoteka.get(SettingsCards.startingPoint)),
                      onSubmitted: (value) {
                        cardoteka.set(SettingsCards.startingPoint, value);
                        // cardoteka.get(SettingsCards.priorityFseName);
                        setState(() {});
                      },
                    ),
                  )
                ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: RichText(
                        text: const TextSpan(children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.file_present_sharp,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.file_open,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  const TableCell(child: SizedBox.shrink()),
                  TableCell(
                      child: IconButton(
                          onPressed: () {
                            cardoteka.set(SettingsCards.patternFromLinks,
                                SettingsCards.patternFromLinks.defaultValue);
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh))),
                  const TableCell(child: SizedBox.shrink()),
                  TableCell(
                    child: TextField(
                      readOnly: true,
                      // expands: true,
                      maxLines: 1,
                      minLines: null,
                      controller: TextEditingController(
                          text: cardoteka.get(SettingsCards.patternFromLinks)),
                      onSubmitted: (value) {
                        cardoteka.set(SettingsCards.patternFromLinks, value);
                        // cardoteka.get(SettingsCards.priorityFseName);
                        setState(() {});
                      },
                    ),
                  )
                ]),
              ]),
        ));
  }
}
