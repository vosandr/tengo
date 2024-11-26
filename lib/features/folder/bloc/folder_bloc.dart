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
    on<PrimaryActionHappened>((event, emit) {
      _onPrimaryActionHappened(event, emit);
    });
    on<ReadingLinksHappened>((event, emit) {
      _onReadingLinksHappened(event, emit);
    });
    on<ChangePathEvent>((event, emit) {
      _onChangePathHappened(event, emit);
    });
    // on<BooleanVarChanged>((event, emit) async {
    //   await _onBooleanVarChanged(event, emit);
    // });
  }

  final FolderRepository _folderRepository;

  // Future<void> _onShowFolder(
  //   ShowFolder event,
  //   Emitter<FolderState> emit,
  // ) async {
  //   _clearData(emit, event);
  //   await _loadData(emit);
  // }

  void _onPrimaryActionHappened(
      PrimaryActionHappened event, Emitter<FolderState> emit) {
    _clearData(event, emit);

    emit(state.copyWith(
      status: () => FolderStatus.success,
      path: () {
        if (event.action != PrimaryAction.read) {
          return _folderRepository.toParentFolder(path: state.path);
        }
        return state.path;
      },
      fseList: () =>
          state.fseList +
          _folderRepository.primaryAction(
              action: event.action, path: state.path),
    ));
    // print(state.fseList.map((fse) {
    //   return fse.name;
    // }));
    // await _folderRepository.primaryAction(
    //     action: event.action, path: event.path);

    // await _clearData(SecondaryActionHappened(action: Prima, path: path), emit)
    // _doingAction(event, emit);
    // ShowFolder(path: event.path);
  }

  _onReadingLinksHappened(
      ReadingLinksHappened event, Emitter<FolderState> emit) {
    _clearDataInLinks(event, emit);

    emit(state.copyWith(
      status: () => FolderStatus.success,
      path: () {
        return state.path;
      },
      fseList: () =>
          state.fseList +
          _folderRepository.primaryAction(
              action: PrimaryAction.read, path: state.path),
    ));
  }

  // _onBooleanVarChanged(BooleanVarChanged event, Emitter<FolderState> emit) {
  //   switch (event.booleanVar) {
  //     case BooleanVar.textFieldEnabled:
  //       emit(state.copyWith(textFieldEnabled: () => event.value));
  //     // print(state);
  //   }
  // }
  void _onChangePathHappened(ChangePathEvent event, Emitter<FolderState> emit) {
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
      path: () => _folderRepository.toAbsoluteFolder(path: event.path),
    ));
    emit(state.copyWith(
      status: () => FolderStatus.success,
      path: () {
        return state.path;
      },
      fseList: () =>
          state.fseList +
          _folderRepository.primaryAction(
              action: PrimaryAction.read, path: state.path),
    ));
  }

  void _clearData(PrimaryActionHappened event, Emitter<FolderState> emit) {
    // print(state.path);
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
      path: () =>
          _folderRepository.toAbsoluteFolder(path: state.path + event.path),
    ));

    // print(state.path);
  }

  void _clearDataInLinks(
      ReadingLinksHappened event, Emitter<FolderState> emit) {
    emit(state.copyWith(
      fseList: () => const [],
      status: () => FolderStatus.loading,
      path: () =>
          _folderRepository.toAbsoluteFolder(path: event.path + event.name),
    ));
  }
  // Future<void> _doingAction(
  //     PrimaryActionHappened event, Emitter<FolderState> emit) async {

  // }
}
