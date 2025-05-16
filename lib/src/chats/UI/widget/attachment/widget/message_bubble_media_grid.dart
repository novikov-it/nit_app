/// Grid widget to display message attachments as images
part of '../../nit_chat_widgets.dart';

/// Grid widget to display message attachments as images
class MediaGrid extends HookConsumerWidget {
  final NitChatMessage message;

  const MediaGrid({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = useState<List<String>>([]);

    useEffect(() {
      images.value = message.attachmentIds!
          .map((e) => ref.readModel<NitMedia>(e).publicUrl)
          .toList();
      return null;
    }, [message]);

    if (images.value.isEmpty) return const SizedBox.shrink();

    if (images.value.length < 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(images.value.length, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: index == 1 ? 4 : 0),
              child: AspectRatio(
                aspectRatio: 1,
                child: MessageBubbleImageTile(
                  images: images.value,
                  index: index,
                ),
              ),
            ),
          );
        }),
      );
    }

    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(images.value.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: MessageBubbleImageTile(
              images: images.value,
              index: index,
            ),
          ),
        );
      }),
    );
  }
}

class MessageBubbleImageTile extends ConsumerWidget {
  final List<String> images;
  final int index;

  const MessageBubbleImageTile({
    super.key,
    required this.images,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                context.pop();
              }
            },
            child: Dialog.fullscreen(
              backgroundColor: Colors.transparent,
              child: FullscreenAttachmentView(
                images: images,
                startIndex: index,
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
          ),
        ),
      ),
    );
  }
}
