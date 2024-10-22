import 'package:tengo_simple/repositories/fse/fse_repository.dart';

enum FseAction {
  delete,
  rename,
  move,
  copy,
}

class Fse {
  Fse(
      {required this.name,
      required this.type,
      this.path = './',
      this.readedFses,
      this.content});
  String name;
  String type;
  String path;
  List<Fse>? readedFses;
  String? content;

  Fse copyWith({
    String Function()? name,
    String Function()? type,
    String Function()? path,
    List<Fse> Function()? readedFses,
    String Function()? content,
  }) {
    return Fse(
      name: name != null ? name() : this.name,
      type: type != null ? type() : this.type,
      path: path != null ? path() : this.path,
      readedFses: readedFses != null ? readedFses() : this.readedFses,
      content: content != null ? content() : this.content,
    );
  }

  // format() {
  //   name = name.substring(name.lastIndexOf('/'));
  //   if (type == '_Directory') {
  //     name += '/';
  //   }
  // }
}
