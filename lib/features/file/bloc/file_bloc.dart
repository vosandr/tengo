
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tengo/features/folder/bloc/folder_bloc.dart';
import 'package:tengo/features/file/repositories/file_repository.dart';
import 'package:tengo/features/models/fse_action.dart';

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
    on<RenameFile>((event, emit) async {
      await _onRenameFile(event, emit);
    });
    on<WriteFile>((event, emit) async {
      await _onChangeFile(event, emit);
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
    _fileRepository.init(path: state.path, name: state.name);
    emit(
      state.copyWith(
          status: () => FileStatus.success,
          name: () => state.name,
          path: () => state.path,
          content: () {
            return state.content + _fileRepository.showFileData();
          }),
    );
  }

  _onRenameFile(RenameFile event, Emitter<FileState> emit) {
    _fileRepository.rename(newName: event.newName);
    ShowFile(name: event.newName, path: event.path);
    PrimaryActionHappened(action: PrimaryAction.read, path: event.path);
  }

  _onChangeFile(WriteFile event, Emitter<FileState> emit) {
    _fileRepository.write(content: event.content);
    ShowFile(name: event.name, path: event.path);
  }

  // void _setupEventHandlers() {
  //   on<ShowRequestedFile>(_onShowRequestedFile);
  //   on<WaitRequestFileData>(_onWaitRequestFileData);
  // }
}
