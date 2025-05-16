import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
    const textDelegate = RussianAssetPickerTextDelegate();
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        selectedAssets: state.items
            .where((e) => e.isAsset)
            .map((e) => e.asAsset())
            .toList(),
        maxAssets: mediaLimit,
        requestType: RequestType.image,
        gridCount: 3,
        pageSize: 120,
        pickerTheme: AssetPicker.themeData(
          const Color(0xFF0196A2),
        ),
        textDelegate: textDelegate,
      ),
    );
    final media = state.items.where((e) => e.isMedia).toList();

    if (result != null) {
      state = state.copyWith(
        items: [...media, ...result.map((e) => MediaOrAssetWrapper(e))],
      );
    }
  }

  Future<List<NitMedia>> uploadMedia() async {
    state = state.copyWith(isUploading: true);

    try {
      final assetsToUpload = state.items.where((e) => e.isAsset).toList();

      for (var item in assetsToUpload) {
        await _uploadSingleAsset(item);
      }
    } catch (e) {
      log('Ошибка при загрузке медиа: $e');
      return [];
    } finally {
      state = state.copyWith(isUploading: false);
    }

    return state.items.where((e) => e.isMedia).map((e) => e.asMedia()).toList();
  }

  Future<void> _uploadSingleAsset(MediaOrAssetWrapper item) async {
    try {
      final asset = item.asAsset();
      final file = await asset.file;

      final nitMedia = await ref.uploadXFileToServer(
        xFile: XFile(
          file!.path,
          bytes: await file.readAsBytes(),
          name: asset.title,
        ),
        path: 'chat/${ref.signedInUserId}',
      );

      state = state.copyWith(
        loadedCount: (state.loadedCount ?? 0) + 1,
        items: state.items
            .map((e) => e == item ? MediaOrAssetWrapper(nitMedia) : e)
            .toList(),
      );
    } catch (e) {
      log('Ошибка при загрузке ассета: $e');
    }
  }

  void toggleItem(MediaOrAssetWrapper item) {
    final items = state.items;
    final index = items.indexWhere(
      (e) =>
          (e.isAsset && e.asAsset().id == item.asAsset().id) ||
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
  bool get isAsset => item is AssetEntity;

  NitMedia asMedia() => item as NitMedia;
  AssetEntity asAsset() => item as AssetEntity;
}
