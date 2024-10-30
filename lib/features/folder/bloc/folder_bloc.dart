import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo_viewer/repositories/fse/folder_repository.dart';

import 'package:tengo_viewer/repositories/fse/models/fse.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc({required FolderRepository folderRepository})
      : _folderRepository = folderRepository,
        super(const FolderState()) {
    on<ShowFolder>((event, emit) async {
      await _onShowFolder(event, emit);
    });
  }

  final FolderRepository _folderRepository;

  Future<void> _onShowFolder(
    ShowFolder event,
    Emitter<FolderState> emit,
  ) async {
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
      path: () => _folderRepository.toAbsolute(path: state.path + event.path),
    ));

    await emit.forEach<List<Fse>>(
      _folderRepository.showFolderData(
          path: state.path, priorityFse: Fse(name: '00.md', path: state.path, type: '_File')),
      onData: (fseList) {
        // var fseList = _folderRepository.sort(
        //     state.fseList +
        //         [
        //           _folderRepository.format(
        //             Fse(
        //                 name: fse.path,
        //                 type: fse.runtimeType.toString(),
        //                 path: state.path),
        //           )
        //         ],
        //     _folderRepository.getLinksInFile(
        //         Fse(name: '00.md', path: state.path, type: '_File')),
        //     Fse(name: '00.md', path: state.path, type: '_File'));
        return state.copyWith(
            status: () => FolderStatus.success,
            path: () => state.path,
            fseList: () => state.fseList + fseList);
      },
      onError: (_, __) => state.copyWith(status: () => FolderStatus.failure),
    );
    // print(state.path + '00.md');
  }
  // Future<void> _on
  // Future<void> _onGoUp(GoUp event, Emitter<FolderState> emit) async {
  //   state.copyWith(path: ()=>_folderRepository.toAbsolute(path: state.path+'../'));
  // }
}
