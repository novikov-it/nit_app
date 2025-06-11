import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';
import 'package:nit_app/src/chats/UI/widget/attachment/state/attachment_state.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AttachmentList extends ConsumerWidget {
  const AttachmentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attachmentStateProvider);
    return SizedBox(
      height: state.items.isNotEmpty ? 80 : 0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          return _AttachmentItem(media: state.items[index]);
        },
        separatorBuilder: (context, index) {
          return Gap(4);
        },
      ),
    );
  }
}

class _AttachmentItem extends ConsumerWidget {
  const _AttachmentItem({
    required this.media,
  });

  final MediaOrAssetWrapper media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = ChatTheme.of(context);

    return Stack(
      children: [
        if (media.isMedia)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: media.asMedia().publicUrl,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
        if (media.isAsset)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AssetEntityImage(
              media.asAsset(),
              isOriginal: false,
              thumbnailSize: const ThumbnailSize.square(80),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.error,
                    color: chatTheme.errorColor,
                  ),
                );
              },
              width: 80,
              height: 80,
            ),
          ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap: () {
                  ref
                      .watch(
                        attachmentStateProvider.notifier,
                      )
                      .toggleItem(media);
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: chatTheme.backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: chatTheme.dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.delete_outline,
                      color: chatTheme.errorColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
