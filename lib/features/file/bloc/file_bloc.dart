import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo_editor/repositories/fse/file_repository.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc({required fileRepository})
      : _fileRepository = fileRepository,
        super(const FileState()) {
    // on<WaitRequestFileData>((event, emit) async {
    //   await _onWaitRequestFileData(event, emit);
    // });
    on<ShowFile>((event, emit) async {
      await _onShowFile(event, emit);
    });
    // _setupEventHandlers();
  }

  final FileRepository _fileRepository;
  // Future<void> _onWaitRequestFileData(
  //     WaitRequestFileData event, Emitter<FileState> emit) async {
  //           // print(event.name);
  //   await emit.onEach(_fileRepository.waitReceiveFileData(),
  //       onData: (data) => ShowFile(name: data.name, path: data.path));

  // }

  Future<void> _onShowFile(ShowFile event, Emitter<FileState> emit) async {
    emit(
      state.copyWith(
        status: () => FileStatus.loading,
        name: () => event.name,
        path: () => event.path,
        content: () => '',
      ),
    );
    // print(state.path + state.name);
    await emit.forEach(
        _fileRepository
            .showFileData(state.path + state.name)
            .transform(utf8.decoder),
        onData: (content) => state.copyWith(
              status: () => FileStatus.success,
              name: () => state.name,
              path: () => state.path,
              content: () {
                // print(content);
                return state.content + content;
              },
            ),
        onError: (_, __) => state.copyWith(status: () => FileStatus.failure));
  }

  // void _setupEventHandlers() {
  //   on<ShowRequestedFile>(_onShowRequestedFile);
  //   on<WaitRequestFileData>(_onWaitRequestFileData);
  // }
}
