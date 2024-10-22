import 'package:flutter/material.dart';

class FileContentPage extends StatelessWidget {
  const FileContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56 * 2),
          child: Column(
            children: [
              AppBar(title: Text('Pages')),
              AppBar(
                title: TextFormField(initialValue: 'Name'),
              )
            ],
          )),
      body: TextFormField(
        readOnly: 'hasFile'!=false?false:true,
        initialValue: '',
        onChanged: (string) {
          print(string);
        },
        expands: true,
        maxLines: null,
        decoration: const InputDecoration(),
      ),
    );
  }
}
