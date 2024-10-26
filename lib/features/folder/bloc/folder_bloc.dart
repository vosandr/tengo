import 'dart:async';
import 'dart:io';
// import 'dart:developer';
// import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo_viewer_prioritising_files/repositories/fse/folder_repository.dart';

import 'package:tengo_viewer_prioritising_files/repositories/fse/models/fse.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc({required FolderRepository folderRepository})
      : _folderRepository = folderRepository,
        super(const FolderState()) {
    on<ShowFolder>((event, emit) async {
      await _onShowFolder(event, emit);
    });
    on<HideFolder>(
      (event, emit) async {
        await _onHideFolder(event, emit);
      },
    );
    on<RequestToShowFile>((event, emit) async {
      await _onRequestToShowFile(event, emit);
    });
    // _setupEventHandlers;
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

    await emit.forEach<FileSystemEntity>(
      _folderRepository.showFolderData(path: state.path),
      onData: (fse) {
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
            fseList: () {
              return _sort(
                state.fseList +
                    [
                      _format(
                        Fse(
                            name: fse.path,
                            type: fse.runtimeType.toString(),
                            path: state.path),
                      )
                    ],
              );
            });
      },
      onError: (_, __) => state.copyWith(status: () => FolderStatus.failure),
    );
  }
  // Future<void> _on
  // Future<void> _onGoUp(GoUp event, Emitter<FolderState> emit) async {
  //   state.copyWith(path: ()=>_folderRepository.toAbsolute(path: state.path+'../'));
  // }

  _onHideFolder(HideFolder event, Emitter<FolderState> emit) {
    emit(
      state.copyWith(
        fseList: () => const [],
        // path: () => _folderRepository.toAbsolute(path: event.path)
      ),
    );
  }

  Fse _format(Fse fse) {
    fse.name = fse.name.substring(fse.name.lastIndexOf('/') + 1);
    if (fse.type == '_Directory') {
      fse.name += '/';
    }
    return fse;
  }

  List<Fse> _sort(List<Fse> fseList) {
    fseList.sort((a, b) {
      if (a.name.startsWith('.') && b.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase().substring(1));
      } else if (a.name.startsWith('.')) {
        return a.name.substring(1).compareTo(b.name.toLowerCase());
      } else if (b.name.startsWith('.')) {
        return a.name.compareTo(b.name.toLowerCase().substring(1));
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return fseList;
  }

  _onRequestToShowFile(RequestToShowFile event, Emitter<FolderState> emit) {}
}
