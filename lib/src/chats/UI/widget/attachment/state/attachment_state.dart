import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attachment_state.g.dart';
part 'attachment_state.freezed.dart';

@riverpod
class AttachmentState extends _$AttachmentState {
  final mediaLimit = 5;
  @override
  AdMediaStateModel build() {
    return const AdMediaStateModel(
      items: [],
    );
  }

  Future openMediaPicker(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    final result = await picker.pickMultiImage();
    final media = state.items.where((e) => e.isMedia).toList();

    if (result != null) {
      state = state.copyWith(
        items: [...media, ...result.map((e) => MediaOrAssetWrapper(e))],
      );
    }
  }

  Future<List<NitMedia>> uploadMedia() async {
    state = state.copyWith(isUploading: true);
    final List<NitMedia> uploadedFiles = [];

    try {
      final List<XFile> assetsToUpload =
          state.items.where((e) => e.isXFile).map((e) => e.asXFile()).toList();

      for (var item in assetsToUpload) {
        final nitMedia = await _uploadSingleAsset(item);
        if (nitMedia != null) {
          uploadedFiles.add(nitMedia);
        }
      }
    } catch (e) {
      log('Ошибка при загрузке медиа: $e');
      return [];
    } finally {
      state = state.copyWith(isUploading: false);
    }

    return uploadedFiles;
  }

  Future<NitMedia?> _uploadSingleAsset(XFile file) async {
    try {
      final nitMedia = await ref.uploadXFileToServer(
        xFile: file,
        path: 'chat/${ref.signedInUserId}',
      );

      // final newList = [
      //   ...state.items
      //       .where((e) => !(e.isXFile && e.asXFile().path == file.path)),
      //   MediaOrAssetWrapper(nitMedia),
      // ];

      state = state.copyWith(
        loadedCount: (state.loadedCount ?? 0) + 1,
        // items: newList,
      );
      return nitMedia;
    } catch (e) {
      log('Ошибка при загрузке ассета: $e');
      return null;
    }
  }

  Future<void> uploadAudio(File file) async {
    state = state.copyWith(isUploading: true);

    try {
      await ref.uploadXFileToServer(
        xFile: XFile(
          file.path,
          bytes: await file.readAsBytes(),
          name: file.path,
        ),
        path: 'chat/${ref.signedInUserId}',
      );
    } catch (e) {
      log('Ошибка при загрузке ассета: $e');
    } finally {
      state = state.copyWith(isUploading: false);
    }
  }

  void toggleItem(MediaOrAssetWrapper item) {
    final items = state.items;
    final index = items.indexWhere(
      (e) =>
          (e.isXFile && e.asXFile().path == item.asXFile().path) ||
          (e.isMedia && e.asMedia().id == item.asMedia().id),
    );
    if (index == -1 && items.length >= mediaLimit) {
      return;
    }
    if (index == -1) {
      state = state.copyWith(items: [...items, item]);
    } else if (index != -1) {
      state = state.copyWith(
        items: [
          ...items.sublist(0, index),
          ...items.sublist(index + 1),
        ],
      );
    }
  }
}

@freezed
class AdMediaStateModel with _$AdMediaStateModel {
  const factory AdMediaStateModel({
    required List<MediaOrAssetWrapper> items,
    @Default(false) bool isUploading,
    int? loadedCount,
  }) = _AdMediaStateModel;
}

class MediaOrAssetWrapper {
  final Object item;

  MediaOrAssetWrapper(this.item);

  bool get isMedia => item is NitMedia;
  bool get isXFile => item is XFile;

  NitMedia asMedia() => item as NitMedia;
  XFile asXFile() => item as XFile;
}
