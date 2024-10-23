import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo_simple/repositories/fse/models/models.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc() : super(FileState()) {
    on<ShowFile>((event, emit) {
      print(event.fse.name);
    });
  }
}
