/// Grid widget to display message attachments as images
part of '../../nit_chat_widgets.dart';

class MediaGrid extends HookConsumerWidget {
  final NitChatMessage message;

  const MediaGrid({
    super.key,
    required this.message,
  });

  Future<List<String>> _loadImages(WidgetRef ref) async {
    if (message.attachmentIds == null || message.attachmentIds!.isEmpty) {
      return [];
    }
    final futures = message.attachmentIds!
        .map((e) async => (await ref.readOrFetchModel<NitMedia>(e)).publicUrl)
        .toList();
    return Future.wait(futures);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesFuture = useMemoized(() => _loadImages(ref), [message.id]);

    final snapshot = useFuture(imagesFuture);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const SizedBox.shrink();
    }
    final images = snapshot.data!;
    if (images.length < 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(images.length, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: index == 1 ? 4 : 0),
              child: AspectRatio(
                aspectRatio: 1,
                child: MessageBubbleImageTile(
                  images: images,
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
      children: List.generate(images.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: MessageBubbleImageTile(
              images: images,
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
