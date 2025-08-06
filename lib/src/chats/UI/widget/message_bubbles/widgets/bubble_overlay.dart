import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nit_app/nit_app.dart';

class BubbleOverlay extends HookConsumerWidget {
  final Widget child;
  final bool isMe;
  final VoidCallback onReply;
  final VoidCallback onCopy;
  final Future<void> Function() onDelete;
  final VoidCallback onEdit;
  final void Function(String emoji) onReact;

  const BubbleOverlay({
    super.key,
    required this.child,
    required this.isMe,
    required this.onReply,
    required this.onCopy,
    required this.onDelete,
    required this.onEdit,
    required this.onReact,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ChatTheme.of(context);
    final overlayEntry = useState<OverlayEntry?>(null);
    final tapPosition = useState<Offset?>(null);
    final textColor = Theme.of(context).iconTheme.color;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 250),
    );

    void showOverlay() {
      if (overlayEntry.value != null) return;

      final overlay = Overlay.of(context);
      final screenSize = MediaQuery.of(context).size;
      final tap = tapPosition.value ??
          Offset(screenSize.width / 2, screenSize.height / 2);

      double overlayWidth = 260;
      double overlayHeight =
          isMe ? 180 : 60; // Разная высота в зависимости от isMe

      double left = tap.dx - overlayWidth / 2;
      double top = tap.dy - overlayHeight;

      if (left < 8) left = 8;
      if (left + overlayWidth > screenSize.width - 8) {
        left = screenSize.width - overlayWidth - 8;
      }
      if (top < 32) top = 32;
      if (top + overlayHeight > screenSize.height - 16) {
        top = screenSize.height - overlayHeight - 16;
      }

      final entry = OverlayEntry(
        builder: (context) => FadeTransition(
          opacity: animationController,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  animationController.reverse().then((value) {
                    overlayEntry.value?.remove();
                    overlayEntry.value = null;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                left: left,
                top: top,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Curves.easeOutBack,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: overlayWidth,
                      height: overlayHeight,
                      decoration: BoxDecoration(
                        color:
                            theme.mainTheme.backgroundColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Реакции
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       for (final emoji in [
                          //         '👍',
                          //         '❤️',
                          //         '😂',
                          //         '😮',
                          //         '😢',
                          //       ])
                          //         _AnimatedIconButton(
                          //           onPressed: () {
                          //             animationController
                          //                 .reverse()
                          //                 .then((value) {
                          //               overlayEntry.value?.remove();
                          //               overlayEntry.value = null;
                          //             });
                          //           },
                          //           icon: Text(
                          //             emoji,
                          //             style: const TextStyle(fontSize: 24),
                          //           ),
                          //         ),
                          //     ],
                          //   ),
                          // ),
                          // Divider(
                          //   color: theme.mainTheme.dividerColor,
                          //   height: 1,
                          // ),
                          // Действия в зависимости от isMe
                          _AnimatedListTile(
                            leading: Icon(
                              Icons.reply,
                              color: textColor,
                            ),
                            title: Text(
                              'Ответить',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                            onTap: () {
                              onReply();
                              animationController.reverse().then((value) {
                                overlayEntry.value?.remove();
                                overlayEntry.value = null;
                              });
                            },
                          ),
                          if (isMe) ...[
                            _AnimatedListTile(
                              leading: Icon(
                                Icons.edit,
                                color: textColor,
                              ),
                              title: Text(
                                'Редактировать',
                                style: TextStyle(
                                  color: textColor,
                                ),
                              ),
                              onTap: () {
                                onEdit();
                                animationController.reverse().then((value) {
                                  overlayEntry.value?.remove();
                                  overlayEntry.value = null;
                                });
                              },
                            ),
                            _AnimatedListTile(
                              leading: Icon(
                                Icons.delete,
                                color: theme.mainTheme.errorColor,
                              ),
                              title: Text(
                                'Удалить',
                                style: TextStyle(
                                  color: theme.mainTheme.errorColor,
                                ),
                              ),
                              onTap: () async {
                                await animationController
                                    .reverse()
                                    .then((value) {
                                  overlayEntry.value?.remove();
                                  overlayEntry.value = null;
                                });
                                await onDelete();
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      overlay.insert(entry);
      overlayEntry.value = entry;
      animationController.forward();
    }

    return GestureDetector(
      onTapDown: (details) {
        tapPosition.value = details.globalPosition;
      },
      onLongPress: () {
        showOverlay();
      },
      child: child,
    );
  }
}

// Виджет с анимацией нажатия для IconButton
class _AnimatedIconButton extends HookWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const _AnimatedIconButton({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
    );

    return GestureDetector(
      onTapDown: (_) {
        animationController.forward();
      },
      onTapUp: (_) {
        animationController.reverse();
        onPressed();
      },
      onTapCancel: () {
        animationController.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: icon,
      ),
    );
  }
}

// Виджет с анимацией нажатия для ListTile
class _AnimatedListTile extends HookWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback onTap;

  const _AnimatedListTile({
    required this.leading,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
    );

    return GestureDetector(
      onTapDown: (_) {
        animationController.forward();
      },
      onTapUp: (_) {
        animationController.reverse();
        onTap();
      },
      onTapCancel: () {
        animationController.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: ListTile(
          leading: leading,
          title: title,
        ),
      ),
    );
  }
}
