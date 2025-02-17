import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nit_ui_kit/nit_ui_kit.dart';
import 'package:serverpod_chat_client/module.dart';

class MessageCard extends ConsumerWidget {
  final ChatMessage message;
  final bool sentByMe;

  const MessageCard({
    super.key,
    required this.message,
    required this.sentByMe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (message.senderInfo == null) {
    //   final pieces = message.message.split(':');
    //   return Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Divider(
    //             thickness: 10,
    //             color: Colors.black,
    //           ),
    //           Text(
    //             '${pieces[0]}\n${DateFormat('HH:mm, dd.MM').format(message.time.toLocal())}',
    //             style: context.textTheme.labelMedium!,
    //             textAlign: TextAlign.center,
    //           ),
    //           const Divider(
    //             thickness: 10,
    //             color: Colors.black,
    //           ),
    //         ],
    //       ),
    //       if (pieces.length > 1)
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Card(
    //             elevation: 8,
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text(
    //                 pieces[1],
    //               ),
    //             ),
    //           ),
    //         )
    //     ],
    //   );
    // }

    // final bool sentByMe = message.sender < 0
    //     ? message.senderInfo?.userName == ref.read(unauthenticatedUsername)
    //     : message.sender == ref.read(nitSessionStateProvider).signedInUser?.id;

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!sentByMe)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _userAvatar(context),
              ),
            Container(
              padding: const EdgeInsets.only(
                left: 6.0,
                top: 6.0,
                right: 6.0,
              ),
              constraints: BoxConstraints(
                maxWidth: context.isMobile
                    ? MediaQuery.sizeOf(context).width * 0.5
                    : MediaQuery.sizeOf(context).width * 0.2,
              ),
              decoration: BoxDecoration(
                color: sentByMe
                    ? context.colorScheme.primaryFixedDim
                    : context.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: sentByMe
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: sentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (!sentByMe)
                              Text(
                                message.senderInfo?.fullName ??
                                    message.senderInfo?.userName ??
                                    message.senderName ??
                                    '___',
                                // ref.read(unauthenticatedUsername),
                                style:
                                    context.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onSurface,
                                  fontSize: 14,
                                ),
                              ),
                            if (message.message.isNotEmpty)
                              _messageText(context, sentByMe),
                            if (message.attachments != null &&
                                message.attachments!.isNotEmpty)
                              _attachments(sentByMe),
                            const Gap(8),
                          ],
                        ),
                        if (message.attachments != null &&
                            message.attachments!.isNotEmpty)
                          _timeRow(context, sentByMe),
                      ],
                    ),
                  ),
                  if (message.attachments == null ||
                      message.attachments!.isEmpty)
                    const Gap(8),
                  if (message.attachments == null ||
                      message.attachments!.isEmpty)
                    _timeRow(context, sentByMe),
                ],
              ),
            ),
            // if (fromSelf)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 10),
            //     child: _userAvatar(context),
            //   ),
          ],
        ),
      ),
    );
  }

  Row _timeRow(BuildContext context, bool fromSelf) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat('HH:mm').format(message.time.toLocal()),
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 11,
            color: fromSelf
                ? context.colorScheme.surfaceContainerLowest
                : context.colorScheme.onSurface,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 4),
        //   child: SvgPicture.asset(
        //     AppIconsSvg.iconAllRead,
        //     width: 10,
        //     height: 7,
        //     colorFilter: ColorFilter.mode(
        //       fromSelf
        //           ? context.colorScheme.surfaceContainerLowest
        //           : context.colorScheme.onSurface,
        //       BlendMode.srcIn,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Text _messageText(BuildContext context, bool fromSelf) {
    return Text(
      message.message,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: fromSelf
                ? context.colorScheme.surfaceContainerLowest
                : context.colorScheme.onSurface,
          ),
    );
  }

  Widget _attachments(bool fromSelf) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: message.attachments?.length,
      itemBuilder: (context, index) {
        final preurl = message.attachments![index].url;
        final url = preurl
            .replaceFirst(
              'telemed.nit.studio.storage.yandexcloud.net',
              'telemed.nit.studio',
            )
            .replaceFirst('http:', 'https:');

        // if (message.attachments![index].previewWidth == null) {
        //   return RichText(
        //     textWidthBasis: TextWidthBasis.longestLine,
        //     text: LinkTextSpan(
        //       url: Uri.parse(
        //         url,
        //       ),
        //       text: message.attachments![index].fileName,
        //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //             color: fromSelf
        //                 ? context.colorScheme.surfaceContainerLowest
        //                 : context.colorScheme.onSurface,
        //             decoration: TextDecoration.underline,
        //           ),
        //       isMobile: context.isMobile,
        //     ),
        //   );
        // }
        return GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Image.network(
                url,
              ),
            ),
          ),
          child: Image.network(
            url,
          ),
        );
      },
    );
  }

  CircleAvatar _userAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: context.theme.colorScheme.primary,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.black.withOpacity(0.5),
        foregroundImage: NetworkImage(
          message.senderInfo?.imageUrl ?? '',
        ),
      ),
    );
  }
}
