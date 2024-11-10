import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tengo/features/folder/repositories/folder_repository.dart';
import 'package:tengo/features/models/fse_action.dart';

import 'package:tengo/features/models/fse.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc({required FolderRepository folderRepository})
      : _folderRepository = folderRepository,
        super(const FolderState()) {
    // on<ShowFolder>((event, emit) async {
    //   await _onShowFolder(event, emit);
    // });
    on<PrimaryActionHappened>((event, emit) async {
      await _onPrimaryActionHappened(event, emit);
    });
    on<SecondaryActionHappened>((event, emit) async {
      await _onSecondaryActionHappened(event, emit);
    });
  }

  final FolderRepository _folderRepository;

  // Future<void> _onShowFolder(
  //   ShowFolder event,
  //   Emitter<FolderState> emit,
  // ) async {
  //   _clearData(emit, event);
  //   await _loadData(emit);
  // }

  Future<void> _onPrimaryActionHappened(
      PrimaryActionHappened event, Emitter<FolderState> emit) async {
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
    ));
    await _folderRepository.primaryAction(
        action: event.action, path: event.path);
    // await _clearData(SecondaryActionHappened(action: Prima, path: path), emit)
    await _readData(emit);
    // ShowFolder(path: event.path);
  }

  _onSecondaryActionHappened(
      SecondaryActionHappened event, Emitter<FolderState> emit) {
    _folderRepository.secondaryAction(
      action: event.action,
      path: event.path,
      secondaryPath: event.secondaryPath,
    );
  }

  void _clearData(SecondaryActionHappened event, Emitter<FolderState> emit) {
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
      path: () => _folderRepository.toAbsolute(path: state.path + event.path),
    ));
  }

  Future<void> _readData(Emitter<FolderState> emit) async {
    await emit.forEach<List<Fse>>(
      _folderRepository.showFolderData(
          path: state.path,
          priorityFse: Fse(
            name: '00.md',
            path: state.path,
            type: '_File',
          )),
      onData: (fseList) {
        return state.copyWith(
          status: () => FolderStatus.success,
          path: () => state.path,
          fseList: () => state.fseList + fseList,
        );
      },
      onError: (_, __) => state.copyWith(
        status: () => FolderStatus.failure,
      ),
    );
  }
}
